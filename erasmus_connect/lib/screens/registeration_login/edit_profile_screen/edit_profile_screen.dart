import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erasmus_connect/models/connect_plus_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:searchfield/searchfield.dart';
import '../../../services/database.dart';

import '../../../core/utils/image_constant.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/custom_image_view.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({Key? key, required this.goToPage}) : super(key: key);

  final Function(int) goToPage;
  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  late TextEditingController fullName,
      nickName,
      phone,
      country,
      city,
      school,
      erasmusSchool;

  late ConnectPlusUser user;

  var asd = ["", "Erkek", "Kadın"];

  var schools = [
    "İstanbul Teknik Üniversitesi",
    "Orta Doğu Teknik Üniversitesi",
    "Boğaziçi Üniversitesi",
    "Boras Üniversitesi",
    "Uppsala Üniversitesi",
    "Stockholm Üniversitesi",
    "Bologna Üniversitesi",
    "Milano Üniversitesi",
    "Rome La Sapienze Üniversitesi",
    "Münih Teknik Üniversitesi",
    "Berlin Teknik Üniversitesi",
    "Stuttgart Üniversitesi",
    "Oxford Üniversitesi",
    "Cambridge Üniversitesi",
    "London Imperial Üniversitesi"
  ];

  String type = "Öğrenci";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ConnectPlusUser user = ref.read(userProvider);
    fullName = TextEditingController();
    nickName = TextEditingController();
    phone = TextEditingController();
    country = TextEditingController();
    city = TextEditingController();
    school = TextEditingController();
    erasmusSchool = TextEditingController();
    fullName.text = user.fullName!;
    nickName.text = user.nickName!;
    phone.text = user.phone!;
    type = user.type!;
    school.text = user.school!;
    erasmusSchool.text = user.erasmusSchool!;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullName.dispose();
    nickName.dispose();
    phone.dispose();
    country.dispose();
    city.dispose();
    school.dispose();
    erasmusSchool.dispose();
  }

  String gender = "Erkek";

  void UpdateProfile() async {
    ConnectPlusUser user = ref.read(userProvider);
    await FirebaseFireStoreMethods(FirebaseFirestore.instance)
        .UpdateUser(
            uId: user.uId,
            fullName: fullName.text,
            nickName: nickName.text,
            phone: phone.text,
            gender: gender,
            type: type,
            country: country.text,
            city: city.text,
            school: school.text,
            erasmusSchool: erasmusSchool.text)
        .then((value) {
      ConnectPlusUser oldUser = ref.read(userProvider);
      ref.read(userProvider.notifier).ChangeUser(ConnectPlusUser(
          profilePicture: user.profilePicture,
          uId: user.uId,
          fullName: fullName.text,
          nickName: nickName.text,
          mail: user.mail,
          phone: user.phone,
          gender: gender,
          country: country.text,
          city: city.text,
          isMailVerified: user.isMailVerified,
          school: school.text,
          erasmusSchool: erasmusSchool.text,
          type: type,
          aboutMe: oldUser.aboutMe,
          lessons: oldUser.lessons,
          skills: oldUser.skills,
          chatUsers: oldUser.chatUsers));
      print(value);
      print("1");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 255, 248, 242),
        foregroundColor: Color.fromARGB(255, 255, 248, 242),
        surfaceTintColor: Color.fromARGB(255, 255, 248, 242),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 210, 210, 210),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: IconButton(
                onPressed: () {
                  widget.goToPage(4);
                },
                icon: Icon(
                  size: 24,
                  CupertinoIcons.chevron_back,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              'Profilini Düzenle',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 5.0,
                    color: Color.fromARGB(81, 0, 0, 0),
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
            Icon(
              CupertinoIcons.chevron_back,
              color: Colors.transparent,
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 248, 242),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              BerkTextField(
                label: "Full Name",
                controller: fullName,
              ),
              SizedBox(
                height: 10,
              ),
              BerkTextField(
                label: "Nickname",
                controller: nickName,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 350,
                child: Row(
                  children: [
                    Container(
                      width: 170,
                      height: 60,
                      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromRGBO(117, 117, 117, 1),
                              width: 2),
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(243, 248, 255, 1)),
                      child: DropdownButton(
                          hint: Text("Country"),
                          isExpanded: true,
                          value: type,
                          items: ["Öğrenci", "Mentor"].map((String item) {
                            return DropdownMenuItem(
                                child: Text(item), value: item);
                          }).toList(),
                          onChanged: (x) {
                            setState(() {
                              type = x!;
                            });
                          }),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 170,
                      height: 60,
                      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromRGBO(117, 117, 117, 1),
                              width: 2),
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(243, 248, 255, 1)),
                      child: DropdownButton(
                          value: gender,
                          hint: Text("Gender"),
                          isExpanded: true,
                          items: ["Erkek", "Kadın"].map((String item) {
                            return DropdownMenuItem(
                                child: Text(item), value: item);
                          }).toList(),
                          onChanged: (x) {
                            setState(() {
                              gender = x!;
                            });
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 350,
                child: Row(
                  children: [
                    SizedBox(
                      width: 170,
                      child: BerkTextField(
                        label: "Ülke",
                        controller: country,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 170,
                      child: BerkTextField(
                        label: "Şehir",
                        controller: city,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              BerkSearchField(
                  label: "Okuduğu Okul",
                  controller: school,
                  suggestions: schools),
              SizedBox(height: 10),
              BerkSearchField(
                  label: "Erasmus Okulu",
                  controller: erasmusSchool,
                  suggestions: schools),
              SizedBox(height: 10),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  UpdateProfile();
                },
                child: Container(
                  alignment: Alignment.center,
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
                    color: Color.fromARGB(255, 197, 126, 62),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Kaydet',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
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

class BerkTextField extends StatelessWidget {
  const BerkTextField({Key? key, required this.label, required this.controller})
      : super(key: key);

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 60,
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(117, 117, 117, 1), width: 2),
          borderRadius: BorderRadius.circular(10),
          color: Color.fromRGBO(243, 248, 255, 1)),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          labelText: label,
          labelStyle: TextStyle(
              color: Color.fromRGBO(127, 127, 127, 1),
              fontSize: 14,
              fontFamily: "Roboto"),
          border: InputBorder.none,
        ),
        style: TextStyle(
            height: 1.3,
            color: Color.fromRGBO(33, 33, 33, 1),
            fontSize: 15,
            fontFamily: "Roboto"),
      ),
    );
  }
}

class BerkSearchField extends StatelessWidget {
  const BerkSearchField(
      {Key? key,
      required this.label,
      required this.controller,
      required this.suggestions})
      : super(key: key);

  final String label;
  final TextEditingController controller;
  final List<String> suggestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 60,
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(117, 117, 117, 1), width: 2),
          borderRadius: BorderRadius.circular(10),
          color: Color.fromRGBO(243, 248, 255, 1)),
      child: SearchField(
        controller: controller,
        searchInputDecoration: InputDecoration(
          enabledBorder: InputBorder.none,
          labelText: label,
          labelStyle: TextStyle(
              color: Color.fromRGBO(127, 127, 127, 1),
              fontSize: 14,
              fontFamily: "Roboto"),
          border: InputBorder.none,
        ),
        maxSuggestionsInViewPort: 6,
        suggestionsDecoration:
            SuggestionDecoration(borderRadius: BorderRadius.circular(10)),
        suggestions: suggestions.map((e) => SearchFieldListItem(e)).toList(),
        onSuggestionTap: (e) {},
      ),
    );
  }
}
