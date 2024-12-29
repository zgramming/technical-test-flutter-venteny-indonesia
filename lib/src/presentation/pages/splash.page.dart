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
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AppConfigCubit, AppConfigState>(
        listener: (context, state) {
          if (state is AppConfigStateLoaded) {
            final appConfig = state.appConfig;
            final loginCredential = appConfig.loginCredential;
            final alreadyOnboarded = appConfig.alreadyShowOnboarding;

            if (!alreadyOnboarded) {
              context.goNamed(RoutersName.onboarding);
              return;
            }

            if (loginCredential.isEmpty) {
              context.goNamed(RoutersName.login);
              return;
            }

            context.goNamed(RoutersName.welcome);
          }
        },
        child: BlocBuilder<AppConfigCubit, AppConfigState>(
          builder: (context, state) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            // Loading indicator
            children: [
              if (state is AppConfigStateLoading)
                const Center(child: CircularProgressIndicator()),

              // Error message
              if (state is AppConfigStateError)
                Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
