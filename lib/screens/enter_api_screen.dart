import 'package:chatgptapp/providers/apikey_provider.dart';
import 'package:chatgptapp/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants/constants.dart';

class EnterApiScreen extends StatelessWidget {
  const EnterApiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController apiKeyController = TextEditingController();
    final WebViewController webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
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
                  onPressed: () {
                    _launchUrl(context, webViewController);
                  },
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
