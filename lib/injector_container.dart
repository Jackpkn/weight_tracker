import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weight_tracker/src/config/router/route_name.dart';
import 'package:weight_tracker/src/config/router/router.dart';
import 'package:weight_tracker/src/features/user/data/datasource/local_data_source.dart';
import 'package:weight_tracker/src/features/user/data/model/user_model.dart';
import 'package:weight_tracker/src/features/user/data/repository/user_repository_impl.dart';
import 'package:weight_tracker/src/features/user/domain/repository/user_repository.dart';
import 'package:weight_tracker/src/features/user/domain/usecases/create_user_use_case.dart';
import 'package:weight_tracker/src/features/user/domain/usecases/get_user_use_cases.dart';
import 'package:weight_tracker/src/features/user/presentation/bloc/user_bloc.dart';

Future<Isar> openDatabase() async {
  final dir = await getApplicationDocumentsDirectory();
  return await Isar.open(
    [UserModelSchema],
    directory: dir.path,
  );
}

final serviceLocator = GetIt.instance;
Future<void> setupServiceLocator() async {
  serviceLocator.registerSingleton<Isar>(await openDatabase());
  _appDependencies();
  _userDependencies();
}

void _appDependencies() {
  serviceLocator
    ..registerLazySingleton<RouteName>(() => RouteName())
    ..registerLazySingleton<Routers>(() => Routers());
}

void _userDependencies() {
  // Initialize Hive box

  // data source

  serviceLocator
    ..registerFactory<LocalDataSource>(
        () => LocalDataSourceImpl(serviceLocator()))
    // repository
    ..registerFactory<UserRepository>(
        () => UserRepositoryImpl(serviceLocator()))
    // use case
    ..registerFactory(() => CreateUserUseCase(serviceLocator()))
    ..registerFactory(() => GetUserUseCase(serviceLocator()))
    // bloc
    ..registerFactory(
      () => UserBloc(
          createUserUseCase: serviceLocator(),
          getUserUseCase: serviceLocator()),
    );
}
