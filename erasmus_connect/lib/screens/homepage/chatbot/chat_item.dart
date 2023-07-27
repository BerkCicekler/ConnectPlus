import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final String text;
  final bool isMe;
  const ChatItem({
    super.key,
    required this.text,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: MediaQuery.of(context).size.height * 0.01),
          padding: isMe
              ? EdgeInsets.all(12)
              : EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 0),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          decoration: BoxDecoration(
            color: isMe
                ? Color.fromARGB(255, 255, 251, 242)
                : Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: isMe
              ? Text(
                  text,
                  style: TextStyle(
                    color: Color.fromARGB(255, 64, 62, 57),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        color: Color.fromARGB(255, 64, 62, 57),
                      ),
                    ),
                    Divider(
                      color: Color.fromARGB(255, 233, 228, 209),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              padding: EdgeInsets.only(left: 0),
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/images/chatbot_img_4.png',
                                width: 24,
                                height: 24,
                                fit: BoxFit.contain,
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.only(left: 0),
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/images/chatbot_img_5.png',
                                width: 24,
                                height: 24,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              padding: EdgeInsets.only(left: 0),
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/images/chatbot_img_3.png',
                                width: 24,
                                height: 24,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Text('Kopyala')
                          ],
                        ),
                      ],
                    )
                  ],
                ),
        ),
      ],
    );
  }
}
