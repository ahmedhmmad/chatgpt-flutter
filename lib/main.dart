import 'package:chatgptapp/providers/apikey_provider.dart';
import 'package:chatgptapp/providers/models_provider.dart';
import 'package:chatgptapp/providers/theme_provider.dart';
import 'package:chatgptapp/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'screens/home_screen.dart';

void main() {
  runApp(ChangeNotifierProvider<ThemeProvider>(
    create: (_) => ThemeProvider()..getTheme(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          home: ChatScreen(),
        ));
  }
}
