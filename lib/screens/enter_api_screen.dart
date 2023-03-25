import '../providers/apikey_provider.dart';
import '../screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants/constants.dart';
import '../services/app_localizations.dart';

class EnterApiScreen extends StatelessWidget {
  const EnterApiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController apiKeyController = TextEditingController();
    final WebViewController webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      // ..setNavigationDelegate(
      //   NavigationDelegate(
      //     onProgress: (int progress) {
      //       // Update loading bar.
      //     },
      //     onPageStarted: (String url) {},
      //     onPageFinished: (String url) {},
      //     onWebResourceError: (WebResourceError error) {},
      //     onNavigationRequest: (NavigationRequest request) {
      //       if (request.url.startsWith('https://www.youtube.com/')) {
      //         return NavigationDecision.prevent;
      //       }
      //       return NavigationDecision.navigate;
      //     },
      //   ),
      // )
      ..loadRequest(Uri.parse(apiWebsite));

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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText:
                      AppLocalizations.of(context)?.translate("enter_api"),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.translate("dont_have_api")),
                TextButton(
                  onPressed: () {
                    _launchUrl(context, webViewController);
                  },
                  child:
                      Text(AppLocalizations.of(context)!.translate("get_api")),
                ),
              ],
            ),
            MaterialButton(
              textColor: Colors.white,
              minWidth: 200,
              height: 50,
              autofocus: true,
              color: scaffoldBgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                if (apiKeyController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(AppLocalizations.of(context)!
                          .translate("please_enter_api")),
                    ),
                  );
                  return;
                }

                Provider.of<ApiProvider>(context, listen: false)
                    .setApiKey(apiKeyController.text);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChatScreen()));
              },
              child: Text(
                AppLocalizations.of(context)!.translate("submit"),
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> _launchUrl() async {
  //   final Uri _url = Uri.parse(apiWebsite);

  //   if (!await launchUrl(_url)) {
  //     throw Exception('Could not launch $_url');
  //   }
  // }

  // _launchUrl(WebViewController x) {
  //   return Scaffold(
  //     appBar: AppBar(title: const Text('Flutter Simple Example')),
  //     body: WebViewWidget(controller: x),
  //   );
  // }

  void _launchUrl(BuildContext context, WebViewController controller) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => Scaffold(
                appBar: AppBar(
                  title: const Text('OpenAI API'),
                  backgroundColor: scaffoldBgColor,
                  actions: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                body: WebViewWidget(controller: controller),
              )),
    );
  }
}
