import 'package:chatgptapp/services/assets_managers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/constants.dart';
import '../widgets/chat_widget.dart';
import '../widgets/drawer_widget.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  final bool _isTyping = true;
  final TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  AssetsManager.chatLogo,
                  scale: 5,
                ),
                Text('ChatGPT'),
              ],
            ),
            Icon(Icons.more_vert_rounded),
          ],
        ),
        // leading: Image.asset(AssetsManager.chatLogo),
        elevation: 0.0,
      ),
      drawer: MyDrawaer(),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: chatMessages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: ChatWidget(
                      message: chatMessages[index]["message"].toString(),
                      messageIndex: int.parse(
                          chatMessages[index]['chatIndex'].toString()),
                    ),
                  );
                },
              ),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.blue,
                size: 18.0,
              ),
            ],
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchTextController,
                      onSubmitted: (value) {},
                      decoration: InputDecoration.collapsed(
                        hintText: 'Type a message',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
