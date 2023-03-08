import 'package:chatgptapp/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatGPT'),
        actions: [
          IconButton(
            icon: Provider.of<ThemeProvider>(context).isDarkMode
                ? Icon(Icons.light_mode)
                : Icon(Icons.dark_mode),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          )
        ],
      ),
      body: Center(
        child: Text('Hello World'),
      ),
    );
  }
}
