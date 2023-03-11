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
            mainAxisAlignment: messageIndex == 0
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Image.asset(
                messageIndex == 0
                    ? AssetsManager.chatLogo
                    : AssetsManager.userImage,
                height: 30,
                width: 30,
              ),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              messageIndex != 0
                  ? Row(
                      children: [
                        InkWell(
                            onTap: () {},
                            child: const Icon(Icons.thumb_up_alt_outlined,
                                color: Colors.white)),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {},
                          child: const Icon(Icons.thumb_down_alt_outlined,
                              color: Colors.white),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          )),
    );
  }
}
