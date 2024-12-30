import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/color.dart';

import 'config/enum.dart';
import 'config/font.dart';
import 'config/routes.dart';
import 'injection.dart';
import 'presentation/cubit/app_config.cubit.dart';
import 'presentation/cubit/auth.cubit.dart';
import 'presentation/cubit/task.cubit.dart';
import 'presentation/cubit/task_detail.cubit.dart';
import 'presentation/cubit/task_filter_query.cubit.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final inputDecorationTheme = InputDecorationTheme(
      fillColor: Colors.grey[200],
      filled: true,
      hintStyle: bodyFont.copyWith(fontSize: 12, color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.all(8),
    );

    final lightTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        secondary: secondaryColor,
        primary: primaryColor,
        surface: Colors.white,
        surfaceTint: Colors.white,
      ),
      useMaterial3: true,
      textTheme: bodyFontTheme(),
      scaffoldBackgroundColor: Colors.grey.shade100,
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: primaryColor,
      ),
      inputDecorationTheme: inputDecorationTheme,
    );

    final darkTheme = ThemeData.dark().copyWith(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        hintStyle: bodyFont.copyWith(fontSize: 12, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(8),
      ),
      
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AppConfigCubit>()),
        BlocProvider(create: (context) => sl<AuthCubit>()),
        BlocProvider(create: (context) => sl<TaskCubit>()),
        BlocProvider(create: (context) => sl<TaskDetailCubit>()),
        BlocProvider(create: (context) => sl<TaskFilterQueryCubit>()),
      ],
      child: BlocBuilder<AppConfigCubit, AppConfigState>(
        builder: (context, state) {
          final isLoaded = state is AppConfigStateLoaded;
          final currentTheme =
              isLoaded ? state.appConfig.themeType : ThemeType.light;

          return MaterialApp.router(
            title: 'Task Management App',
            routerConfig: router,
            theme: currentTheme == ThemeType.light ? lightTheme : darkTheme,
          );
        },
      ),
    );
  }
}
