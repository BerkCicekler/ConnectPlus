import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erasmus_connect/screens/homepage/main_screen/messaging_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/connect_plus_user.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({super.key, required this.goToPage});

  final Function(int) goToPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 248, 242),
        appBar: AppBar(
          shadowColor: Color.fromARGB(255, 247, 235, 225),
          backgroundColor: Color.fromRGBO(255, 144, 34, 0.51),
          title: Center(
            child: Text(
              "Mesajlar",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        filled: true,
                        fillColor: Color.fromARGB(255, 250, 229, 210),
                        hintText: 'Ara...',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 237, 164, 126),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 237, 164, 126),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        // Handle search bar input
                      },
                      autofocus: false,
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromARGB(
                          255, 250, 229, 210), // Background color of the button
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        // Add your onTap logic here
                      },
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Image.asset(
                          'assets/images/filter_img.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("users").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  if (ref.read(userProvider).uId != "") {
                    Map<String, dynamic>? chatUsers =
                        ref.read(userProvider).chatUsers;
                    List<String>? keysList = chatUsers?.keys.toList();
                    print(chatUsers.toString());
                    List<Widget> chats = [];

                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      if (keysList!.contains(snapshot.data!.docs[i].id)) {
                        chats.add(DMUserMessageContainer(
                          profilePicture:
                              snapshot.data!.docs[i].get("profilePicture"),
                          id: snapshot.data!.docs[i].id,
                          email: snapshot.data!.docs[i].get("mail"),
                          name: snapshot.data!.docs[i].get("fullName"),
                          lastMessage: chatUsers?[snapshot.data!.docs[i].id]
                              ["lastMessage"],
                          ref: ref,
                          goToPage: goToPage,
                          timeOut: chatUsers?[snapshot.data!.docs[i].id]
                              ["timeOut"] as Timestamp,
                        ));
                      }
                    }
                    return SingleChildScrollView(
                        child: Column(
                      children: chats,
                    ));
                  }
                  return Text("account needed");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChatsTopBar extends StatelessWidget {
  const ChatsTopBar({super.key, required this.fastDMUsers});

  final List<Widget> fastDMUsers;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.lightBlue,
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  ...fastDMUsers
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class FastDMUserContainer extends StatelessWidget {
  const FastDMUserContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(
                    image: AssetImage("assets/images/Default_pp.png"),
                    fit: BoxFit.cover),
                border: Border.all(color: Colors.black, width: 1)),
          ),
          Text(
            "Berk Çiçekler",
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(64, 58, 122, 1)),
            maxLines: 1,
          )
        ],
      ),
    );
  }
}

class DMUserMessageContainer extends StatelessWidget {
  const DMUserMessageContainer(
      {Key? key,
      required this.profilePicture,
      required this.name,
      required this.lastMessage,
      required this.id,
      required this.email,
      required this.ref,
      required this.goToPage,
      required this.timeOut})
      : super(key: key);

  final profilePicture, name, lastMessage, id, email;

  final Timestamp timeOut;

  final WidgetRef ref;

  final Function(int) goToPage;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        DateTime currentTime = DateTime.now();
        DateTime timeOutas = DateTime.parse(timeOut.toDate().toString());
        Duration diff = timeOutas.difference(currentTime);
        if (!diff.isNegative) {
          ref.read(receieverIdProvider.notifier).state = id;
          goToPage(24);
        }
      },
      child: Container(
        width: width * 0.99,
        height: 80,
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                      image: profilePicture != ""
                          ? Image.network(profilePicture, fit: BoxFit.cover)
                              .image
                          : AssetImage("assets/images/Default_pp.png"),
                      fit: BoxFit.cover),
                  border: Border.all(color: Colors.black, width: 1)),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${name}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "${lastMessage}",
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      fontFamily: "Roboto"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

final receieverIdProvider = StateProvider<String>((ref) => "");
