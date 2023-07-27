import 'package:erasmus_connect/screens/homepage/chatbot/chatbot_button.dart';
import 'package:erasmus_connect/screens/homepage/chatbot/models/chat_model.dart';
import 'package:erasmus_connect/screens/homepage/chatbot/providers/chat_providers.dart';
import 'package:erasmus_connect/screens/homepage/chatbot/services/ai_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum InputMode {
  text,
}

class TextFieldWidget extends ConsumerStatefulWidget {
  const TextFieldWidget({super.key});

  @override
  ConsumerState<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends ConsumerState<TextFieldWidget> {
  InputMode _inputMode = InputMode.text;
  final _messageController = TextEditingController();
  AIHandler _openAI = AIHandler();
  var _isReplying = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              keyboardType: TextInputType.text,
              controller: _messageController,
              decoration: InputDecoration(
                suffixIcon: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/chatbot_img_2.png'),
                  backgroundColor: Colors.transparent,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                filled: true,
                fillColor: Color.fromARGB(255, 255, 255, 255),
                hintText: 'Bana bir şey sor...',
                hintStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Color.fromARGB(255, 166, 163, 157),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          ChatbotButton(
            isReplying: _isReplying,
            inputMode: _inputMode,
            sendTextMessage: () {
              final message = _messageController.text;
              _messageController.clear();
              sendTextMessage(message);
            },
          ),
        ],
      ),
    );
  }

  void setInputMode(InputMode inputMode) {}

  void sendTextMessage(String message) async {
    setReplyingState(true);
    addChatToList(message, true, DateTime.now().toString());
    addChatToList("Yazıyor...", false, 'yaziyor');
    final aiResponse = await _openAI.getResponse(message);
    removeTyping();
    addChatToList(aiResponse, false, DateTime.now().toString());
    setReplyingState(false);
  }

  void setReplyingState(bool isReplying) {
    setState(() {
      _isReplying = isReplying;
    });
  }

  removeTyping() {
    final chats = ref.read(chatsProvider.notifier);
    chats.removeTyping();
  }

  void addChatToList(String message, bool isMe, String id) {
    final chats = ref.read(chatsProvider.notifier);
    chats.add(
      ChatModel(
        id: id,
        message: message,
        isMe: isMe,
      ),
    );
  }
}
