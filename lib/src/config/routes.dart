import 'package:go_router/go_router.dart';

import '../presentation/pages/login.page.dart';
import '../presentation/pages/onboarding.page.dart';
import '../presentation/pages/splash.page.dart';
import '../presentation/pages/welcome.page.dart';

class RoutersName {
  static const splash = 'splash';
  static const login = 'login';
  static const onboarding = 'onboarding';
  static const welcome = 'welcome';
}

final router = GoRouter(initialLocation: '/splash', routes: [
  GoRoute(
      path: '/splash',
      name: RoutersName.splash,
      builder: (context, state) => const SplashPage()),
  GoRoute(
      path: '/login',
      name: RoutersName.login,
      builder: (context, state) => const LoginPage()),
  GoRoute(
      path: '/onboarding',
      name: RoutersName.onboarding,
      builder: (context, state) => const OnboardingPage()),
  GoRoute(
      path: '/welcome',
      name: RoutersName.welcome,
      builder: (context, state) => const WelcomePage()),
]);
