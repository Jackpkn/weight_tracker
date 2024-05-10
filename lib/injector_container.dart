import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weight_tracker/src/app_exports.dart';

Future<Isar> openDatabase() async {
  final dir = await getApplicationDocumentsDirectory();
  return await Isar.open(
    [UserModelSchema, WeightModelSchema],
    directory: dir.path,
  );
}

final serviceLocator = GetIt.instance;
Future<void> setupServiceLocator() async {
  serviceLocator.registerSingleton<Isar>(await openDatabase());

  _userDependencies();

  _weightDependencies();
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
    ..registerFactory(() => DeleteUserUseCase(serviceLocator()))
    // bloc
    ..registerFactory(
      () => UserBloc(
          deleteUserUseCase: serviceLocator(),
          createUserUseCase: serviceLocator(),
          getUserUseCase: serviceLocator(),
          deleteWeightEntryUse: serviceLocator()),
    );
}

void _weightDependencies() {
  // data source
  serviceLocator
    ..registerFactory<WeightLocalDataSource>(
        () => WeightLocalDataSourceImpl(serviceLocator()))
    // repository
    ..registerFactory<WeightRepository>(
        () => WeightRepositoryImpl(serviceLocator()))
    // use case
    ..registerFactory(() => AddWeightUseCase(serviceLocator()))
    ..registerFactory(() => EditWeightEntryUse(serviceLocator()))

    // bloc

    ..registerFactory(() => GetSortedWeight(serviceLocator()))
    ..registerFactory(() => GetAllWeightUseCase(serviceLocator()))
    ..registerFactory(() => DeleteWeightEntryUse(serviceLocator()))
    ..registerFactory(() => WeightBloc(
          addWeightUseCase: serviceLocator(),
          getWeightEntries: serviceLocator(),
          editWeightEntry: serviceLocator(),
          entriesWithTime: serviceLocator(),
          deleteWeightEntryUse: serviceLocator(),
        ));
}
