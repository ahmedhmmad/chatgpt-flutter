import 'package:chatgptapp/services/api_services.dart';
import 'package:chatgptapp/services/assets_managers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../models/chat_model.dart';
import '../providers/models_provider.dart';
import '../widgets/chat_widget.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/dropdown_widget.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;
  String? currentModel;
  List models = [];
  late List<ChatModel> chatMessages = [];

  final TextEditingController searchTextController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final modelProvider = Provider.of<ModelsProvider>(context);
    String currentModel = modelProvider.currentModel;

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
                const Text('ChatGPT'),
              ],
            ),
            IconButton(
              onPressed: () async {
                await showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25.0)),
                    ),
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Choose Model',
                                style: TextStyle(fontSize: 12)),
                            Flexible(
                              child: DropDownWidget(),
                            ),
                          ],
                        ),
                      );
                    });
              },
              icon: const Icon(Icons.more_vert_rounded),
            )
          ],
        ),
        // leading: Image.asset(AssetsManager.chatLogo),
        elevation: 0.0,
      ),
      drawer: const MyDrawaer(),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                controller: scrollController,
                itemCount: chatMessages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: ChatWidget(
                      message: chatMessages[index].message,
                      messageIndex: chatMessages[index].chatIndex,
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
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Type a message',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () async {
                        await sendMessage(
                            searchTextController.text, currentModel);
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void scrollList() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> sendMessage(String text, String currentModel) async {
    try {
      setState(() {
        _isTyping = true;
        chatMessages.add(ChatModel(
          message: text,
          chatIndex: 0,
        ));
        searchTextController.text = '';
      });
      chatMessages
          .addAll(await APIServices().getChatResponse(text, currentModel));

      setState(() {});
    } finally {
      setState(() {
        scrollList();
        _isTyping = false;
      });
    }
  }
}
