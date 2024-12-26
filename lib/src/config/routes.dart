import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../presentation/pages/dashboard.page.dart';

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
    await Future.delayed(const Duration(seconds: 2));
    router.goNamed(RoutersName.welcome);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        // Loading indicator
        children: [
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Login Page'),
      ),
    );
  }
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => OnboardingPageState();
}

class OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Onboarding Page'),
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Search Page'),
      ],
    );
  }
}

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Setting Page'),
      ],
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _selectedIndex = 0;

  void _onDestinationSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> destinations = [
      const NavigationDestination(
        icon: Icon(
          FontAwesomeIcons.house,
          size: 24,
          color: Colors.grey,
        ),
        selectedIcon: Icon(
          FontAwesomeIcons.houseUser,
          size: 24,
          color: Colors.white,
        ),
        label: 'Dashboard',
        tooltip: 'Dashboard',
      ),
      const NavigationDestination(
        icon: Icon(
          FontAwesomeIcons.magnifyingGlass,
          size: 24,
          color: Colors.grey,
        ),
        selectedIcon: Icon(
          FontAwesomeIcons.magnifyingGlassArrowRight,
          size: 24,
          color: Colors.white,
        ),
        label: 'Search',
        tooltip: 'Search',
      ),
      const NavigationDestination(
        icon: Icon(
          FontAwesomeIcons.gear,
          size: 24,
          color: Colors.grey,
        ),
        selectedIcon: Icon(
          FontAwesomeIcons.gears,
          size: 24,
          color: Colors.white,
        ),
        label: 'Setting',
        tooltip: 'Setting',
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          DashboardPage(),
          SearchPage(),
          SettingPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        elevation: 5,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        indicatorColor: Colors.blue,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations: destinations,
      ),
    );
  }
}
