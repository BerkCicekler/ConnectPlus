import 'package:erasmus_connect/screens/homepage/chatbot/text_field.dart';
import 'package:flutter/material.dart';

class ChatbotButton extends StatefulWidget {
  final VoidCallback _sendTextMessage;
  final InputMode _inputMode;
  final bool _isReplying;
  const ChatbotButton({
    super.key,
    required InputMode inputMode,
    required VoidCallback sendTextMessage,
    required bool isReplying,
  })  : _inputMode = inputMode,
        _sendTextMessage = sendTextMessage,
        _isReplying = isReplying;

  @override
  State<ChatbotButton> createState() => _ChatbotButtonState();
}

class _ChatbotButtonState extends State<ChatbotButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 199, 56),
            Color.fromARGB(255, 255, 51, 39),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ), // Background color of the button
      ),
      child: InkWell(
          borderRadius: BorderRadius.circular(45),
          onTap: widget._sendTextMessage,
          child: Padding(
            padding: EdgeInsets.only(top: 18, left: 12, right: 12, bottom: 12),
            child: Image.asset(
              'assets/images/chatbot_img_1.png',
              fit: BoxFit.contain,
            ),
          )),
    );
  }
}
