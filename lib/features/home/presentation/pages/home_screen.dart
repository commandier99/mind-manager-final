import 'package:flutter/material.dart';
import 'package:mind_manager/shared/widgets/top_bar_widget.dart';
import 'package:mind_manager/shared/widgets/bottom_navigation_widget.dart';
import 'package:mind_manager/shared/widgets/side_menu_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Start with Home selected by default
  int _bottomNavIndex = 0; // Tracks selection shown in the BottomNavigationBar
  bool _lastSelectedFromBottom = true; // true when last selection came from bottom nav
  String _currentTitle = 'Home';

  // All possible pages that can be displayed in the body
  final List<Widget> _pages = [
    // --- Bottom Navigation Bar Items (Indices 0-3) ---
    const Center(child: Text('Home View Content')),
    const Center(child: Text('Boards View Content')),
    const Center(child: Text('Tasks View Content')),
    const Center(child: Text('Dashboard View Content')),

    // --- Side Menu Items (Indices 4-9) ---
    const Center(child: Text('Profile Page Content')),
    const Center(child: Text('Notifications Page Content')),
    const Center(child: Text('Search/Discover Page Content')),
    const Center(child: Text('Settings Page Content')),
    const Center(child: Text('Help/FAQ Page Content')),
    const Center(child: Text('About Page Content')),
  ];

  void _onItemTapped(int index, {bool fromBottom = false}) {
    setState(() {
      _lastSelectedFromBottom = fromBottom;
      if (fromBottom && index >= 0 && index <= 3) {
        _bottomNavIndex = index;
      }
      _selectedIndex = index;
      switch (index) {
        // Bottom Navigation Bar Titles
        case 0:
          _currentTitle = 'Home';
          break;
        case 1:
          _currentTitle = 'Boards';
          break;
        case 2:
          _currentTitle = 'Tasks';
          break;
        case 3:
          _currentTitle = 'Dashboard';
          break;
        // Side Menu Titles
        case 4:
          _currentTitle = 'Profile';
          break;
        case 5:
          _currentTitle = 'Notifications';
          break;
        case 6:
          _currentTitle = 'Search & Discover';
          break;
        case 7:
          _currentTitle = 'Settings';
          break;
        case 8:
          _currentTitle = 'Help/FAQ';
          break;
        case 9:
          _currentTitle = 'About';
          break;
        default:
          _currentTitle = 'Mind-Manager';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: _currentTitle),
      drawer: SideMenu(
        onSelect: (indexFromSideMenu) {
          // SideMenu already closes the drawer; map its indices to _pages (4..9)
          _onItemTapped(indexFromSideMenu + 4, fromBottom: false);
        },
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigation(
        currentIndex: _lastSelectedFromBottom ? _bottomNavIndex : null, // null hides highlight
        onTap: (i) => _onItemTapped(i, fromBottom: true),
      ),
    );
  }
}
