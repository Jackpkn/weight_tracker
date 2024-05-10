import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/injector_container.dart';
import 'package:weight_tracker/src/app_exports.dart';
import 'package:weight_tracker/src/config/themes/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
        create: (BuildContext context) => serviceLocator.get<UserBloc>()),
    BlocProvider(
        create: (BuildContext context) => serviceLocator.get<WeightBloc>()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Weight tracker',
      debugShowCheckedModeBanner: false,
      routerConfig: Routers().router,
      themeMode: ThemeMode.dark,
      theme: AppTheme.themeData,
    );
  }
}
