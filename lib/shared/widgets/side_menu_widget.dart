import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final ValueChanged<int>? onSelect;

  const SideMenu({super.key, this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Mind-Manager',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              onSelect?.call(0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              Navigator.pop(context);
              onSelect?.call(1);
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Search & Discover'),
            onTap: () {
              Navigator.pop(context);
              onSelect?.call(2);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              onSelect?.call(3);
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help / FAQ'),
            onTap: () {
              Navigator.pop(context);
              onSelect?.call(4);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              onSelect?.call(5);
            },
          ),
        ],
      ),
    );
  }
}