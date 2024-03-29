import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/apikey_provider.dart';
import 'providers/chat_provider.dart';
import 'providers/models_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/token_provider.dart';
import 'screens/chat_screen.dart';
import 'screens/enter_api_screen.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'services/app_localizations.dart';

void main() {
  runApp(ChangeNotifierProvider<ThemeProvider>(
    create: (_) => ThemeProvider()..getTheme(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<bool> isApiSet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiKey = prefs.getString('apiKey') ?? '';
    if (apiKey == '') {
      //print('API Key not set');
      return false;
    } else {
      //print('API Key set');
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
          ChangeNotifierProvider<ModelsProvider>(
            create: (_) => ModelsProvider(),
          ),
          Provider<ApiProvider>(
            create: (_) => ApiProvider()..getApiKey(),
          ),
          ChangeNotifierProvider<ChatProvider>(
            create: (_) => ChatProvider(),
          ),
          ChangeNotifierProvider<TokenProvider>(
            create: (_) => TokenProvider(),
          ),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'), // English
                Locale('ar'), // Arabic
              ],
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                for (var locale in supportedLocales) {
                  if (deviceLocale != null &&
                      deviceLocale.languageCode == locale.languageCode) {
                    return deviceLocale;
                  }
                }

                return supportedLocales.first;
              },
              debugShowCheckedModeBanner: false,
              title: 'ChatGPT',
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: themeProvider.themeMode,
              home: FutureBuilder<bool>(
                future: isApiSet(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      color: Colors.white,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    bool apiSet = snapshot.data ?? false;
                    return apiSet ? const ChatScreen() : const EnterApiScreen();
                  }
                },
              ),
            );
          },
        ));
  }
}
