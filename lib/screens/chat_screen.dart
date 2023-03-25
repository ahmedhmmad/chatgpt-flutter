import '../constants/constants.dart';
import '../services/api_services.dart';
import '../services/assets_managers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../models/chat_model.dart';
import '../providers/chat_provider.dart';
import '../providers/models_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/chat_widget.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/dropdown_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;
  String? currentModel;
  List models = [];

  // late List<ChatModel> chatMessages = [];

  final TextEditingController searchTextController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final modelProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    String currentModel = modelProvider.currentModel;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            themeProvider.isDarkMode ? Colors.black26 : scaffoldBgColor,
        title: Row(
          mainAxisSize:
              MainAxisSize.min, // set mainAxisSize to MainAxisSize.min
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              AssetsManager.chatLogo,
              scale: 7,
            ),
            const SizedBox(
                width: 8), // add some spacing between the logo and the text
            Flexible(
              fit: FlexFit.loose, // use FlexFit.loose for the flexible child
              child: Row(
                children: [
                  const Text('GPT-Model: ', style: TextStyle(fontSize: 12)),
                  Text(
                    currentModel.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
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
                          Text('Choose Model', style: TextStyle(fontSize: 12)),
                          Flexible(
                            child: DropDownWidget(),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.more_vert_rounded),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      drawer: const MyDrawaer(),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                controller: scrollController,
                itemCount: chatProvider.getChatMessages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: ChatWidget(
                      message: chatProvider.getChatMessages[index].message,
                      messageIndex:
                          chatProvider.getChatMessages[index].chatIndex,
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
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 35),
                      decoration: BoxDecoration(
                        color: themeProvider.isDarkMode
                            ? Colors.black45
                            : scaffoldBgColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: searchTextController,
                        onSubmitted: (value) {},
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Type a message',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors
                                .white70, // set a lighter color for the hint text
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.send, color: Colors.blue),
                      onPressed: () async {
                        if (searchTextController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(milliseconds: 500),
                              backgroundColor: Colors.red,
                              content: Text('Please enter a message'),
                            ),
                          );
                          return;
                        } else if (currentModel.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(milliseconds: 500),
                              backgroundColor: Colors.red,
                              content: Text('Please select a model'),
                            ),
                          );
                          return;
                        } else {
                          await sendMessage(searchTextController.text,
                              currentModel, chatProvider);
                        }
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

  Future<void> sendMessage(
      String text, String currentModel, ChatProvider provider) async {
    try {
      setState(() {
        _isTyping = true;
        provider.addMessage(ChatModel(
          message: text,
          chatIndex: 0,
        ));
        searchTextController.text = '';
      });
      if (currentModel == 'gpt-3.5-turbo' ||
          currentModel == 'gpt-3.5' ||
          currentModel == 'gpt-3.0' ||
          currentModel == 'gpt-3.5-turbo-0301') {
        provider.addAllMessages(
            await APIServices().getChatGptResponse(text, currentModel));
      } else {
        provider.addAllMessages(
            await APIServices().getChatResponse(text, currentModel));
      }

      setState(() {});
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Something went wrong ${error.toString()}'),
        ),
      );
    } finally {
      setState(() {
        scrollList();
        _isTyping = false;
      });
    }
  }
}
