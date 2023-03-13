import 'package:chatgptapp/providers/apikey_provider.dart';
import 'package:chatgptapp/providers/models_provider.dart';
import 'package:chatgptapp/providers/theme_provider.dart';
import 'package:chatgptapp/screens/chat_screen.dart';
import 'package:chatgptapp/screens/enter_api_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'screens/home_screen.dart';

void main() {
  runApp(ChangeNotifierProvider<ThemeProvider>(
    create: (_) => ThemeProvider()..getTheme(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  bool isApiSet() {
    SharedPreferences.getInstance().then((prefs) {
      String apiKey = prefs.getString('apiKey') ?? '';
      if (apiKey == '') {
        print('API Key not set');
        return false;
      } else {
        print('API Key set');
        return true;
      }
    });
    print('exit');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<ThemeProvider>(create: (_) => ThemeProvider()..getTheme()),
          Provider<ModelsProvider>(create: (_) => ModelsProvider()),
          Provider<ApiProvider>(create: (_) => ApiProvider()..getApiKey()),
          // Provider<AnotherThing>(create: (_) => AnotherThing()),
        ],

        //   MultiProvider(
        //     providers:[
        //     ChangeNotifierProvider(
        //       Provider<ThemeProvider>(create: (_)=>ThemeProvider()..getTheme(),),
        //       Provider<ModelsProvider>(create: (_)=>ModelsProvider()..getModels()),
        //     ),
        //     ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ChatGPT',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: Provider.of<ThemeProvider>(context).themeMode,
          home: isApiSet() ? ChatScreen() : const EnterApiScreen(),
        ));
  }
}
