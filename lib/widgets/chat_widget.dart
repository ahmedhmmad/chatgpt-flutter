import 'package:animated_text_kit/animated_text_kit.dart';
import '../services/assets_managers.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget(
      {Key? key, required this.message, required this.messageIndex})
      : super(key: key);

  final String message;
  final int messageIndex;

  @override
  Widget build(BuildContext context) {
    return Material(
      //color: messageIndex == 0 ? scaffoldBgColor : cardColor,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: messageIndex == 0
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (messageIndex != 0)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset(
                  AssetsManager.userImage,
                  height: 30,
                  width: 30,
                ),
              ),
            Container(
              decoration: BoxDecoration(
                color: messageIndex == 0
                    ? const Color(0xff0078FF)
                    : const Color(0xffF1F0F0),
                borderRadius: BorderRadius.circular(20.0),
              ),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.6,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 10.0,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    message,
                    textStyle: TextStyle(
                      color: messageIndex == 0 ? Colors.white : Colors.black,
                      fontSize: 16.0,
                    ),
                    speed: const Duration(milliseconds: 50),
                  ),
                ],
                isRepeatingAnimation: false,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
            ),
            if (messageIndex == 0)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Image.asset(
                  AssetsManager.chatLogo,
                  height: 30,
                  width: 30,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
