import 'package:flutter/material.dart';

import '../widgets/drawer_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: const Text('ChatGPT'),
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
      drawer: const MyDrawaer(),
    );
    return scaffold;
  }
}
