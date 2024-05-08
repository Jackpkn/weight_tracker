import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/injector_container.dart';
import 'package:weight_tracker/src/config/router/router.dart';
import 'package:weight_tracker/src/features/user/presentation/bloc/user_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
        create: (BuildContext context) => serviceLocator.get<UserBloc>())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Weight tracker',
      routerConfig: serviceLocator.get<Routers>().router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
