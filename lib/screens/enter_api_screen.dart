import 'package:chatgptapp/providers/apikey_provider.dart';
import 'package:chatgptapp/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';

class EnterApiScreen extends StatelessWidget {
  const EnterApiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController apiKeyController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter API Key'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: apiKeyController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter API Key',
                ),
              ),
            ),
            MaterialButton(
              autofocus: true,
              color: scaffoldBgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                Provider.of<ApiProvider>(context, listen: false)
                    .setApiKey(apiKeyController.text);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatScreen()));
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
