import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erasmus_connect/screens/homepage/main_screen/accommodation_page.dart';
import 'package:erasmus_connect/screens/homepage/main_screen/schools_page.dart';
import 'package:erasmus_connect/screens/homepage/main_screen/search_list_page.dart';
import 'package:erasmus_connect/screens/homepage/main_screen/travel_page.dart';
import 'package:erasmus_connect/screens/homepage/video_conference.dart';
import 'package:erasmus_connect/screens/registeration_login/login_screen/login_screen.dart';
import 'package:erasmus_connect/screens/registeration_login/register_screen/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  final Function(int) goToPage;
  HomePage({required this.goToPage});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<bool> dropdownOpenState = [false, false, false, false, false];

  final List<String> images = [];

  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String searchText = '';

  // late User loggedInUser;
  void _showAlertDialogForAccess(BuildContext context, message) {
    showDialog(
      context: context,
      builder: (
        BuildContext context,
      ) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 189, 104, 28),
          // title: Text('Alert'),
          content: Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 238, 217, 198),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  print("burada sorun yok");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RegisterScreen()));
                },
                child: Text(
                  'Kayıt Ol',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAlertDialogLogOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (
        BuildContext context,
      ) {
        return AlertDialog(
          actionsPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          alignment: Alignment.center,
          backgroundColor: Color.fromARGB(255, 189, 104, 28),
          actions: [
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  SystemNavigator.pop();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 238, 217, 198),
                  ),
                  child: Text(
                    "Çıkış Yap",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Divider(
              color: Colors.black,
              thickness: 2,
              height: 10,
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 238, 217, 198),
                  ),
                  child: Text(
                    "Vazgeç",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 248, 242),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          backgroundColor: Color.fromARGB(255, 238, 217, 198),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          // Handle button 1 press
                        },
                        child: Text(
                          'Erasmus',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 64, 58, 122),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          backgroundColor: Color.fromARGB(255, 238, 217, 198),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          // Handle button 2 press
                        },
                        child: Text(
                          'Work & Travel',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 64, 58, 122),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(
                              0, 3), // controls the position of the shadow
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/notifications_img.png'),
                      backgroundColor: Color.fromARGB(255, 253, 227, 205),
                      child: IconButton(
                        color: Color.fromARGB(255, 253, 227, 205),
                        onPressed: () => widget.goToPage(18),
                        icon: Icon(Icons.notification_add_outlined),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(
                              0, 3), // controls the position of the shadow
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      foregroundImage: AssetImage(
                        'assets/images/out.png',
                      ),
                      backgroundColor: Color.fromARGB(255, 253, 227, 205),
                      child: IconButton(
                        color: Color.fromARGB(255, 253, 227, 205),
                        onPressed: () {
                          _showAlertDialogLogOut(context);
                        },
                        icon: Icon(Icons.notification_add_outlined),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          filled: true,
                          fillColor: Color.fromARGB(255, 250, 229, 210),
                          hintText: AppLocalizations.of(context).ara,
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
                          setState(() {
                            searchText = value;
                          });
                        },
                        onTap: () {
                          widget.goToPage(23);
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 250, 229,
                            210), // Background color of the button
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {},
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
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  top: 10,
                  bottom: 4,
                ),
                child: Text(
                  AppLocalizations.of(context).basvururehberi,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 100, // Set the desired height for the images
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GestureDetector(
                          onTap: () {
                            widget.goToPage(8);
                          },
                          child: Stack(
                            children: [
                              Image.asset('assets/images/homepage_img_4.png'),
                              Positioned(
                                top: 0,
                                right: 0,
                                left: 0,
                                bottom: 0,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppLocalizations.of(context).vizesurecleri,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 20.0,
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GestureDetector(
                          onTap: () {
                            widget.goToPage(9);
                          },
                          child: Stack(
                            children: [
                              Image.asset('assets/images/homepage_img_2.png'),
                              Positioned(
                                top: 0,
                                right: 0,
                                left: 0,
                                bottom: 0,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppLocalizations.of(context).oturumizni,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 10.0,
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          offset: Offset(3, 3),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GestureDetector(
                          onTap: () {
                            widget.goToPage(11);
                          },
                          child: Stack(
                            children: [
                              Image.asset('assets/images/homepage_img_1.png'),
                              Positioned(
                                top: 0,
                                right: 0,
                                left: 0,
                                bottom: 0,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .sagliksigortasi,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GestureDetector(
                          onTap: () {
                            widget.goToPage(12);
                          },
                          child: Stack(
                            children: [
                              Image.asset('assets/images/homepage_img_3.png'),
                              Positioned(
                                top: 0,
                                right: 0,
                                left: 0,
                                bottom: 0,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppLocalizations.of(context).kaliteliegitim,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                ),
                child: Text(
                  AppLocalizations.of(context).onerilenler,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                padding: EdgeInsets.symmetric(horizontal: 22),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        widget.goToPage(6);
                      },
                      child: Stack(
                        children: [
                          Image.asset('assets/images/homepage_img_8.png'),
                          Positioned(
                            top: 0,
                            right: 0,
                            left: 0,
                            bottom: 0,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                AppLocalizations.of(context)
                                    .konaklamatavsiyeleri,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        widget.goToPage(7);
                      },
                      child: Stack(
                        children: [
                          Image.asset('assets/images/homepage_img_5.png'),
                          Positioned(
                            top: 0,
                            right: 0,
                            left: 0,
                            bottom: 0,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                AppLocalizations.of(context).okullar,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        widget.goToPage(5);
                      },
                      child: Stack(
                        children: [
                          Image.asset('assets/images/homepage_img_6.png'),
                          Positioned(
                            top: 0,
                            right: 0,
                            left: 0,
                            bottom: 0,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                AppLocalizations.of(context).gezilecekrotalar,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        if (_auth.currentUser?.email != null) {
                          widget.goToPage(10);
                        } else {
                          _showAlertDialogForAccess(context,
                              "Mentorluk sayfasına erişmek ve mentorlar ile iletişime geçmek için profil oluşturmanız gerekmektedir. Uygulamaya kayıt olun.");
                        }
                      },
                      child: Stack(
                        children: [
                          Image.asset('assets/images/homepage_img_7.png'),
                          Positioned(
                            top: 0,
                            right: 0,
                            left: 0,
                            bottom: 0,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                AppLocalizations.of(context).mentorluk,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (_auth.currentUser?.email != null) {
                      widget.goToPage(17);
                    } else {
                      _showAlertDialogForAccess(context,
                          "Kaliteli erişim topluluğuna ve aynı okuldan insanların bulunduğu topluluklara katılmak ve mentorluk hizmetinden yararlanmak için profil oluşturmanız gerekmektedir. Uygulamaya kayıt olun.");
                    }
                  },
                  child: Stack(
                    children: [
                      Image.asset('assets/images/homepage_img_11.png'),
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        bottom: 40,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            AppLocalizations.of(context).ayniokuldaninsanlar,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
