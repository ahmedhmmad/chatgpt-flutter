import 'package:chatgptapp/constants/constants.dart';
import 'package:chatgptapp/services/assets_managers.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget(
      {super.key, required this.message, required this.messageIndex});

  final String message;
  final int messageIndex;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: messageIndex == 0 ? scaffoldBgColor : cardColor,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset(
                messageIndex == 0
                    ? AssetsManager.chatLogo
                    : AssetsManager.userImage,
                height: 30,
                width: 30,
              ),
              Text(
                message,
                style: TextStyle(color: Colors.white),
              ),
            ],
          )),
    );
  }
}
