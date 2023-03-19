import 'package:chatgptapp/screens/about_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../screens/settings_screen.dart';

class MyDrawaer extends StatelessWidget {
  const MyDrawaer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text('ChatGPT'),
          ),
          SwitchListTile(
            value:
                Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
            onChanged: (value) {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            title: const Text('Theme'),
            secondary: Provider.of<ThemeProvider>(context).isDarkMode
                ? const Icon(Icons.light_mode_outlined)
                : const Icon(Icons.dark_mode_outlined),
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()));
            },
          ),
          ListTile(
            title: const Text('About'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()));
            },
          ),
        ],
      ),
    );
  }
}
