import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/apikey_provider.dart';
import 'providers/models_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/chat_screen.dart';
import 'screens/enter_api_screen.dart';

void main() {
  runApp(ChangeNotifierProvider<ThemeProvider>(
    create: (_) => ThemeProvider()..getTheme(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<bool> isApiSet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiKey = prefs.getString('apiKey') ?? '';
    if (apiKey == '') {
      print('API Key not set');
      return false;
    } else {
      print('API Key set');
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider()..getTheme(),
        ),
        Provider<ModelsProvider>(
          create: (_) => ModelsProvider(),
        ),
        Provider<ApiProvider>(
          create: (_) => ApiProvider()..getApiKey(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ChatGPT',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: Provider.of<ThemeProvider>(context).themeMode,
        home: FutureBuilder<bool>(
          future: isApiSet(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              bool apiSet = snapshot.data ?? false;
              return apiSet ? ChatScreen() : EnterApiScreen();
            }
          },
        ),
      ),
    );
  }
}
