import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../config/routes.dart';
import '../cubit/app_config.cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => _navigateToNextPage());
  }

  Future<void> _navigateToNextPage() async {
    // await Future.delayed(const Duration(seconds: 2));
    // router.goNamed(RoutersName.welcome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AppConfigCubit, AppConfigState>(
        listener: (context, state) {
          final appConfig = state.appConfig;

          final loginCredential = appConfig?.loginCredential;
          final alreadyOnboarded = appConfig?.alreadyShowOnboarding ?? false;

          if (loginCredential != null || loginCredential?.isNotEmpty == true) {
            if (alreadyOnboarded) {
              context.goNamed(RoutersName.login);
              return;
            }

            context.goNamed(RoutersName.onboarding);
          } else {
            context.goNamed(RoutersName.login);
          }
        },
        child: BlocBuilder<AppConfigCubit, AppConfigState>(
          builder: (context, state) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            // Loading indicator
            children: [
              const Text("Loading..."),
              Text("data: ${state.appConfig}"),
            ],
          ),
        ),
      ),
    );
  }
}
