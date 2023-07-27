import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erasmus_connect/models/connect_plus_user.dart';
import 'package:erasmus_connect/screens/homepage/chats_page.dart';
import 'package:erasmus_connect/services/chat.dart';
import 'package:erasmus_connect/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagingPage extends ConsumerStatefulWidget {
  const MessagingPage({super.key, required this.goToPage});

  final Function(int) goToPage;

  @override
  MessagingPageState createState() => MessagingPageState();
}

class MessagingPageState extends ConsumerState<MessagingPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          ref.read(receieverIdProvider),
          ref.read(userProvider).uId,
          ref.read(userProvider).fullName!,
          receieverName,
          _messageController.text);
      _messageController.text = "";
    }
  }

  void setReceieverName() async {
    await FirebaseFireStoreMethods(FirebaseFirestore.instance)
        .GetUser(ref.read(receieverIdProvider))
        .then((value) {
      receieverName = value?["fullName"];
    });
    print(receieverName);
  }

  var receieverName = "";

  @override
  Widget build(BuildContext context) {
    final String receieverId = ref.watch(receieverIdProvider);
    setReceieverName();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 247, 235, 225),
        appBar: AppBar(
          shadowColor: Color.fromARGB(255, 247, 235, 225),
          backgroundColor: Color.fromRGBO(255, 144, 34, 0.52),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 20,
                  ),
                  onPressed: () {
                    widget.goToPage(1);
                  },
                ),
              ),
              Center(
                child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(receieverId)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      return Row(
                        children: [
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image(
                                image:
                                    snapshot.data!.get("profilePicture") != ""
                                        ? Image.network(
                                                snapshot.data!
                                                    .get("profilePicture"),
                                                fit: BoxFit.cover)
                                            .image
                                        : AssetImage(
                                            "assets/images/Default_pp.png"),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(snapshot.data!.get("fullName")),
                        ],
                      );
                      return Text("error");
                    }
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  widget.goToPage(22);
                },
                icon: Icon(Icons.call),
              )
            ],
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            //messages
            Expanded(child: _buildMessageList()),

            _buildMessageInput(),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          ref.read(receieverIdProvider), _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var aligment = data['senderId'] == _firebaseAuth.currentUser!.uid
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: aligment,
      child: Column(
        children: [
          ChatBubble(message: data['message']),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.attach_file),
        ),
        Expanded(
            child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Color.fromRGBO(243, 246, 246, 1),
              borderRadius: BorderRadius.circular(20)),
          child: TextField(
            controller: _messageController,
            decoration: InputDecoration.collapsed(hintText: "Mesaj Yaz."),
          ),
        )),
        IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt_outlined)),
        IconButton(onPressed: sendMessage, icon: Icon(Icons.send))
      ],
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  const ChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Color.fromRGBO(250, 246, 237, 1),
      ),
      child: Text(
        "${message}",
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
