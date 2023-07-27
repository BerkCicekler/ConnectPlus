import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erasmus_connect/models/connect_plus_user.dart';
import 'package:erasmus_connect/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/database.dart';
import 'mentors.dart';

class MentorShowcasePage extends ConsumerWidget {
  const MentorShowcasePage({Key? key, required this.goToPage})
      : super(key: key);

  final Function(int) goToPage;

  Future<Map<String, dynamic>?> getData(String uId) async {
    final Map<String, dynamic>? userCollection =
        await FirebaseFireStoreMethods(FirebaseFirestore.instance).GetUser(uId);
    return userCollection;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    final x = ref.watch(targetuId);
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 247, 235, 225),
        body: Stack(
          children: [
            FutureBuilder(
              future: getData(x),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(child: const CircularProgressIndicator()),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const Text("hata");
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        MentorShowCaseTop(
                          width: width,
                          profilePicture: snapshot.data!["profilePicture"],
                          fullName: snapshot.data!["fullName"],
                          nickname: snapshot.data!["nickName"],
                          country: snapshot.data!["country"],
                          school: snapshot.data!["school"],
                          erasmusSchool: snapshot.data!["erasmusSchool"],
                          aboutMe: snapshot.data!["aboutMe"],
                          skills: snapshot.data!["skills"],
                          lessons: snapshot.data!["lessons"],
                        ),
                        SizedBox(height: 10),
                        TextContainer(
                            widget: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hakkımda", style: H2TextStyle()),
                              Text(
                                "${snapshot.data!["aboutMe"]}",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromRGBO(108, 108, 108, 1)),
                              ),
                              Divider(),
                              Text("Yetkinlikler", style: H2TextStyle()),
                              Text("${snapshot.data!["skills"]}"),
                              Divider(),
                              Text("Alınan Dersler", style: H2TextStyle()),
                              Text("${snapshot.data!["lessons"]}"),
                              Divider(),
                              Text("Bağış Yapılacak Kurum",
                                  style: H2TextStyle()),
                              Row(
                                children: [
                                  Container(
                                      width: width * 0.20,
                                      height: 90,
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color.fromRGBO(
                                                117, 117, 117, 1),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color.fromRGBO(243, 248, 255, 1),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: Offset(0,
                                                4), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/unicef.png"),
                                        ),
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: width * 0.45,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Benimle konuşarak Unicef bağışçısı ol!"),
                                        Text("Bağış yap \$1.00"),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 290,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => MyAlertDialog(),
                                      barrierDismissible: true,
                                    ).then((value) {
                                      if (value) {
                                        DateTime timestamp = DateTime.now();
                                        Duration thirtyMinutes =
                                            Duration(minutes: 30);
                                        DateTime newTimestamp =
                                            timestamp.add(thirtyMinutes);
                                        Timestamp lastTime =
                                            Timestamp.fromDate(newTimestamp);

                                        FirebaseFireStoreMethods(
                                                FirebaseFirestore.instance)
                                            .AddChatUsers(
                                                x,
                                                ref.read(userProvider).uId,
                                                lastTime,
                                                ref);
                                      }
                                    });
                                  },
                                  child: Text(
                                    "Bağış yap ve konuşmayı başlat",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepOrange,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                      ],
                    ),
                  );
                }
              },
            ),
            Positioned(
              top: 30,
              left: 20,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Container(
                  height: 40,
                  width: 40,
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
                      goToPage(10);
                    },
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class MentorShowCaseTop extends StatelessWidget {
  const MentorShowCaseTop({
    super.key,
    required this.width,
    required this.profilePicture,
    required this.fullName,
    required this.nickname,
    required this.country,
    required this.school,
    required this.erasmusSchool,
    required this.aboutMe,
    required this.skills,
    required this.lessons,
  });
  final double width;
  final String profilePicture,
      fullName,
      nickname,
      country,
      school,
      erasmusSchool,
      aboutMe,
      skills,
      lessons;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 200,
      padding: EdgeInsets.only(top: 40, left: 50),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(255, 212, 161, 1),
              Color.fromRGBO(251, 141, 39, 1),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60))),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image(
                  image: profilePicture != ""
                      ? Image.network(profilePicture, fit: BoxFit.cover).image
                      : AssetImage("assets/images/Default_pp.png"),
                )),
          ),
          SizedBox(
            width: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: SizedBox(
              width: width * 0.57,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${fullName}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                      width: 180,
                      child: Row(
                        children: [
                          Text(
                            "@${nickname}",
                            style: TextStyle(
                                fontSize: 12, overflow: TextOverflow.ellipsis),
                          ),
                          Spacer(),
                          Text(
                            "${country}",
                            style: TextStyle(overflow: TextOverflow.ellipsis),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "Okul : ${school}",
                    style: TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                  Text(
                    "erasmus okul : ${erasmusSchool}",
                    style: TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 255, 0, 1),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text("Çevrimiçi"),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TextContainer extends StatelessWidget {
  const TextContainer({super.key, required this.widget});

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: widget);
  }
}

TextStyle H2TextStyle() {
  return TextStyle(
      fontSize: 18,
      color: Color.fromRGBO(52, 77, 87, 1),
      fontWeight: FontWeight.bold);
}

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 151, 151, 151),
        ),
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  "Google Pay",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context, false);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.lightBlueAccent),
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                    width: 70,
                    height: 70,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Center(
                      child: Image(
                        image: AssetImage("assets/images/unicef.png"),
                      ),
                    )),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bağış Yap",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "United Nations Children's fundation",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Divider(),
            Text(
              "Bir Sipariş",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "Toplam tutar : \$1.00",
              style: TextStyle(color: Colors.white),
            ),
            Divider(),
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Text(
                  "Ödemeye Geç: ",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, true);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Image(
                      image: AssetImage("assets/images/google_pay.png"),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.0),
      shadowColor: Color.fromRGBO(0, 0, 0, 0.0),
      surfaceTintColor: Color.fromRGBO(0, 0, 0, 0.0),
    );
  }
}
