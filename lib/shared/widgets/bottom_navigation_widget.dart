import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int? currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool noneSelected = currentIndex == null;
    final int effectiveIndex = noneSelected ? 0 : currentIndex!;
    final Color effectiveSelectedColor = noneSelected ? Colors.grey : (Colors.blue[800] ?? Colors.blue);

    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Boards'),
        BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Dashboard'),
      ],
      currentIndex: effectiveIndex,
      selectedItemColor: effectiveSelectedColor,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed, // Add this line for a fixed layout with labels
      onTap: onTap,
    );
  }
}