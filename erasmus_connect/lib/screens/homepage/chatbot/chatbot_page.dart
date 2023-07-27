import 'package:erasmus_connect/models/connect_plus_user.dart';
import 'package:erasmus_connect/screens/homepage/chatbot/chat_item.dart';
import 'package:erasmus_connect/screens/homepage/chatbot/providers/chat_providers.dart';
import 'package:erasmus_connect/screens/homepage/chatbot/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatbotPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ConnectPlusUser user = ref.watch(userProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(128, 255, 144, 34),
          foregroundColor: const Color.fromARGB(128, 255, 144, 34),
          surfaceTintColor: const Color.fromARGB(128, 255, 144, 34),
          shadowColor: const Color.fromARGB(128, 255, 144, 34),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Chatbox',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: user.profilePicture != ""
                        ? Image.network(user.profilePicture.toString(),
                                fit: BoxFit.cover)
                            .image
                        : AssetImage("assets/images/Default_pp.png"),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Color.fromARGB(255, 247, 235, 225),
                            width: 2),
                        color: Color.fromARGB(
                            255, 251, 137, 39), // Replace with desired color
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 247, 235, 225),
        body: Column(
          children: [
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final chats = ref.watch(chatsProvider).reversed.toList();
                  return ListView.builder(
                    reverse: true,
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      return ChatItem(
                        text: chats[index].message,
                        isMe: chats[index].isMe,
                      );
                    },
                  );
                },
              ),
            ),
            TextFieldWidget(),
          ],
        ),
      ),
    );
  }
}
