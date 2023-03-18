import 'package:flutter/material.dart';

import '../models/chat_model.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatMessages = [];

  void addMessage(ChatModel chatModel) {
    chatMessages.add(chatModel);
    notifyListeners();
  }

  void addAllMessages(List<ChatModel> chatModelList) {
    chatMessages.addAll(chatModelList);
    notifyListeners();
  }

  void clearMessages() {
    chatMessages.clear();
    notifyListeners();
  }

  List<ChatModel> get getChatMessages => chatMessages;
}
