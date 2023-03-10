import 'package:chatgptapp/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/drawer_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text('ChatGPT'),
      ),
      body: Center(
        child: Text('Hello World'),
      ),
      drawer: MyDrawaer(),
    );
    return scaffold;
  }
}
