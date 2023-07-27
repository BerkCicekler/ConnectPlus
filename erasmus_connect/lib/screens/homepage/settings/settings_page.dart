import 'package:erasmus_connect/models/connect_plus_user.dart';
import 'package:erasmus_connect/screens/registeration_login/login_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../l10n/l10n.dart';

class SettingsPage extends ConsumerStatefulWidget {
  final Function(int) goToPage;

  const SettingsPage({required this.goToPage, Key? key}) : super(key: key);

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  String dropdownValue1 = "Türkçe";
  String dropdownValue2 = "Aç";

  @override
  Widget build(BuildContext context) {
    ConnectPlusUser user = ref.watch(userProvider);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 248, 242),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(35),
                  color: Color.fromARGB(255, 255, 144, 34),
                ),
                height: 70,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage: user.profilePicture.toString() != "" ? Image.network(user.profilePicture.toString(),
                          fit: BoxFit.cover).image : AssetImage("assets/images/Default_pp.png"),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${user.fullName}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '@${user.nickName}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text(
                  AppLocalizations.of(context).hesap,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context).dilsecenegi,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  height: 35,
                  color: const Color.fromARGB(255, 216, 216, 216),
                  child: DropdownButton<String>(
                    focusColor: Colors.grey,
                    dropdownColor: Color.fromARGB(255, 255, 255, 255),
                    value: dropdownValue1,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 20,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.transparent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue1 = newValue!;
                      });
                      ref.read(selectedLocaleProvider.notifier).state =
                          Locale((newValue! == "Türkçe" ? "tr" : "en"));
                    },
                    items: <String>['Türkçe', 'English']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context).tema,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context).bildirimler,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  height: 35,
                  color: const Color.fromARGB(255, 216, 216, 216),
                  child: DropdownButton<String>(
                    focusColor: Colors.grey,
                    dropdownColor: Color.fromARGB(255, 255, 255, 255),
                    value: dropdownValue2,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 20,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.transparent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue2 = newValue!;
                      });
                    },
                    items: <String>['Aç', 'Kapat']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context).sss,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    widget.goToPage(19);
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context).kullanimsartlari,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    widget.goToPage(20);
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context).gizlilikpolitikasi,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    widget.goToPage(21);
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  if (ref.read(userProvider).uId == "") {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => LoginScreen()));
                  } else {
                    FirebaseAuth.instance.signOut();
                    ref.read(userProvider.notifier).LogOut();
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.35,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 250, 176, 43),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        (ref.read(userProvider).uId == ""
                            ? AppLocalizations.of(context).girisyap
                            : AppLocalizations.of(context).cikisyap),
                        style: TextStyle(
                          color: ref.read(userProvider).uId == ""
                              ? Color.fromRGBO(0, 255, 0, 1)
                              : Color.fromARGB(255, 190, 35, 53),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.arrow_circle_right_outlined,
                        color: Colors.black,
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
