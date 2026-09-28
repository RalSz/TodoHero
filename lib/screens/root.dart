import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'help_screen.dart';
import 'map_screen.dart';
import 'add_screen.dart';
import '../theme/app_theme.dart';
import '../widgets/app_nav_bar.dart';
import '../utils/scope_manager.dart';
import '../dungeon/dungeon_manager.dart';
import '../utils/scopes/dungeon_scope.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int _selectedIndex = 0;
  final DungeonManager _dungeonManager = DungeonManager();

  @override
  void initState() {
    super.initState();
    _dungeonManager.load();
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const MapScreen();
      case 2:
        return const HelpScreen();
      default:
        return const HomeScreen();
    }
  }

  Widget? _displayFAB(int index) {
    if (index == 0)
    {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddScreen()
            ),
          );
        },
        backgroundColor: AppColors.primary,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AppColors.text,),
      );
    }
    else
    {
      return null;
    }
  }

  void _onTabSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return ScopeManager(
      scopes: [
        (child) => DungeonScope(manager: _dungeonManager, child: child)
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: AppNavBar(selectedIndex: _selectedIndex, onTabSelected: _onTabSelected),
          backgroundColor: AppColors.background,
          centerTitle: true,
        ),
        body: _buildScreen(_selectedIndex),
      floatingActionButton: _displayFAB(_selectedIndex),
      )
    );
  }
}