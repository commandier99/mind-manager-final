import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int? _bottomNavIndex = 0;
  String _currentTitle = 'Home';

  int get selectedIndex => _selectedIndex;
  int? get bottomNavIndex => _bottomNavIndex;
  String get currentTitle => _currentTitle;

  static const List<String> _titles = [
    // Bottom nav
    'Home',
    'Boards',
    'Tasks',
    'Dashboard',

    // Side menu
    'Profile',
    'Notifications',
    'Search & Discover',
    'Settings',
    'Help/FAQ',
    'About',
  ];

  void selectFromBottomNav(int index) {
    _selectedIndex = index;
    _bottomNavIndex = index;
    _currentTitle = _titles[index];
    notifyListeners();
  }

  void selectFromSideMenu(int index) {
    _selectedIndex = index;
    _bottomNavIndex = null; // hides bottom nav highlight
    _currentTitle = _titles[index];
    notifyListeners();
  }
}
