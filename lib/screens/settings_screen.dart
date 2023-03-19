import 'package:chatgptapp/providers/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TokenProvider tokenProvider = Provider.of<TokenProvider>(context);
    TextEditingController tokenController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: tokenController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Current Max Token: ${tokenProvider.token}',
                      prefixIcon: const Icon(Icons.money)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: Colors.blue,
                    onPressed: () {
                      tokenProvider
                          .setToken(int.parse(tokenController.text.toString()));
                      //return the previous screen
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                      child: Text('Save',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: Colors.blue,
                    onPressed: () {
                      //return the previous screen
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                      child: Text('Cancel',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}