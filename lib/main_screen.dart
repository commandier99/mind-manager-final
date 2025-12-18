import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mind_manager/shared/widgets/top_bar_widget.dart';
import 'package:mind_manager/shared/widgets/bottom_navigation_widget.dart';
import 'package:mind_manager/shared/widgets/side_menu_widget.dart';
import 'package:mind_manager/shared/providers/navigation_provider.dart';

// Feature pages
import 'package:mind_manager/features/home/presentation/pages/home_page.dart';
import 'package:mind_manager/features/boards/presentation/pages/boards_page.dart';
import 'package:mind_manager/features/tasks/presentation/pages/tasks_page.dart';
import 'package:mind_manager/features/dashboard/presentation/pages/dashboard_page.dart';

// Side-menu pages
import 'package:mind_manager/features/home/presentation/pages/profile_page.dart';
import 'package:mind_manager/features/home/presentation/pages/notifications_page.dart';
import 'package:mind_manager/features/home/presentation/pages/search_page.dart';
import 'package:mind_manager/features/home/presentation/pages/settings_page.dart';
import 'package:mind_manager/features/home/presentation/pages/help_page.dart';
import 'package:mind_manager/features/home/presentation/pages/about_page.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static final List<Widget> _pages = [
    HomePage(),
    BoardsPage(),
    TasksPage(),
    DashboardPage(),
    ProfilePage(),
    NotificationsPage(),
    SearchPage(),
    SettingsPage(),
    HelpPage(),
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final navigation = context.watch<NavigationProvider>();

    return Scaffold(
      appBar: TopBar(title: navigation.currentTitle),

      drawer: SideMenu(
        onSelect: (sideMenuIndex) {
          navigation.selectFromSideMenu(sideMenuIndex + 4);
        },
      ),

      body: _pages[navigation.selectedIndex],

      bottomNavigationBar: BottomNavigation(
        currentIndex: navigation.bottomNavIndex,
        onTap: navigation.selectFromBottomNav,
      ),
    );
  }
}
