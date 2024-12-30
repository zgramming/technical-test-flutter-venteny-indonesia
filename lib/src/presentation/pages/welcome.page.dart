import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../config/color.dart';

import 'task.page.dart';
import 'setting.page.dart';

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
          FontAwesomeIcons.listCheck,
          size: 24,
          color: Colors.grey,
        ),
        selectedIcon: Icon(
          FontAwesomeIcons.checkDouble,
          size: 24,
          color: Colors.white,
        ),
        label: 'Task',
        tooltip: 'Task',
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
          TaskPage(),
          SettingPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        elevation: 5,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        indicatorColor: primaryColor,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations: destinations,
      ),
    );
  }
}
