import 'package:erasmus_connect/models/connect_plus_user.dart';
import 'package:erasmus_connect/screens/registeration_login/login_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/l10n.dart';

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
      appBar: AppBar(
        shadowColor: Color.fromARGB(255, 247, 235, 225),
        backgroundColor: Color.fromARGB(255, 247, 235, 225),
        title: Row(
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
                  CupertinoIcons.chevron_back,
                  size: 20,
                ),
                onPressed: () {
                  widget.goToPage(2);
                },
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 247, 235, 225),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                        backgroundImage: NetworkImage(
                            'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
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
                  'Hesap',
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
                  'Dil Seçeneği',
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
                      print("test");
                      setState(() {
                        dropdownValue1 = newValue!;
                      });
                      ref.read(selectedLocaleProvider.notifier).state =
                          Locale(newValue!);
                      print(newValue!);
                    },
                    items: <String>['Türkçe', 'English']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value == "Türkçe" ? "tr" : "en",
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
                  'Tema',
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
                  'Bildirimler',
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
                  'Sıkça Sorulan Sorular',
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
                  'Kullanım Şartları',
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
                  'Gizlilik Politikası',
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
              SizedBox(height: 20),
              Container(
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Çıkış Yap',
                      style: TextStyle(
                        color: Color.fromARGB(255, 190, 35, 53),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        ref.read(userProvider.notifier).LogOut();
                      },
                      icon: Icon(
                        Icons.arrow_circle_right_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
