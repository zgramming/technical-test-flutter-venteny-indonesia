import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/color.dart';
import 'config/font.dart';

import 'config/routes.dart';
import 'injection.dart';
import 'presentation/cubit/app_config.cubit.dart';
import 'presentation/cubit/auth.cubit.dart';
import 'presentation/cubit/task.cubit.dart';
import 'presentation/cubit/task_detail.cubit.dart';
import 'presentation/cubit/task_filter_query.cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AppConfigCubit>()),
        BlocProvider(create: (context) => sl<AuthCubit>()),
        BlocProvider(create: (context) => sl<TaskCubit>()),
        BlocProvider(create: (context) => sl<TaskDetailCubit>()),
        BlocProvider(create: (context) => sl<TaskFilterQueryCubit>()),
      ],
      child: MaterialApp.router(
        title: 'Task Management App',
        routerConfig: router,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor,
            secondary: secondaryColor,
            primary: primaryColor,
            surface: Colors.white,
            surfaceTint: Colors.white,
          ),
          useMaterial3: true,
          textTheme: bodyFontTheme(theme.textTheme),
          scaffoldBackgroundColor: Colors.grey.shade100,
          cardTheme: CardTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
