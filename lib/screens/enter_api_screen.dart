import 'package:chatgptapp/providers/apikey_provider.dart';
import 'package:chatgptapp/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: apiKeyController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter API Key',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an API Key?'),
                TextButton(
                  onPressed: _launchUrl,
                  child: const Text('Get API Key'),
                ),
              ],
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

  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse(apiWebsite);

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
