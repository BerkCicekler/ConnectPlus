import 'dart:io';
import 'dart:typed_data';

import 'package:erasmus_connect/core/app_export.dart';
import 'package:erasmus_connect/core/utils/utils.dart';
import 'package:erasmus_connect/models/connect_plus_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../registeration_login/edit_profile_screen/edit_profile_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends ConsumerWidget {
  ProfilePage({
    super.key,
    required this.goToPage,
  });
  final Function(int) goToPage;

  ////////////////////////////////////77
  late String _postImageUrl;

  final picker = ImagePicker();
  PickedFile? _imageFile;
  String downloadUrl = ''; // Use 'late' keyword here

  Future<void> chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageFile = PickedFile(pickedFile.path);
      debugPrint('Image selected.-----------------');
    } else {
      debugPrint('Image unselected--------------.');
    }
  }

  Future<void> uploadImage(WidgetRef reff) async {
    if (_imageFile != null) {
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(
                'images/${DateTime.now().toString()}',
              );
      firebase_storage.UploadTask uploadTask = ref.putFile(
        File(_imageFile!.path),
      );

      firebase_storage.TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() {});

      downloadUrl = await ref.getDownloadURL();
      print('Image uploaded. Download URL: $downloadUrl');
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'profilePicture': downloadUrl});
      reff.read(userProvider.notifier).updateProfilePicture(profilePicture: downloadUrl);
      debugPrint(
          '----------------------111Image uploaded. Download URL: $downloadUrl ----------------------------------');
    } else {
      debugPrint('link yok--------------.');
    }
    debugPrint(
        '----------------------222Image uploaded. Download URL: $downloadUrl ----------------------------------');
  }

  ////////////////////////////////////////

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ConnectPlusUser user = ref.watch(userProvider);
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 248, 242),
        body: ProviderScope(
          child: Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image(image: user.profilePicture.toString() != "" ? Image.network(user.profilePicture.toString(),
                              fit: BoxFit.cover).image : AssetImage("assets/images/Default_pp.png"),

                          )
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () async {
                              await chooseImage();
                              await uploadImage(ref);
                            },
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.deepOrange),
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.black,
                                size: 25,
                              ),
                            ),
                          ))
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      user.fullName!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextContainer(
                        goToPage: goToPage,
                        pageNumber: 15,
                        widget: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Nick : ${user.nickName!}"),
                              Text("Mail : ${user.mail!}"),
                              Text("Telefon Numarası : ${user.phone!}"),
                              Text("Okul : ${user.school!}"),
                              Text("Erasmus Okulu : ${user.erasmusSchool!}"),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    TextContainer(
                        goToPage: goToPage,
                        pageNumber: 16,
                        widget: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hakkımda", style: H2TextStyle()),
                              Text(
                                "${user.aboutMe}",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromRGBO(108, 108, 108, 1)),
                              ),
                              Divider(),
                              Text("Yetkinlikler", style: H2TextStyle()),
                              Text("${user.skills}"),
                              Divider(),
                              Text("Alınan Dersler", style: H2TextStyle()),
                              Text("${user.lessons}"),
                              Divider(),
                              Text("Bağış Yapılacak Kurum",
                                  style: H2TextStyle()),
                              Container(
                                  width: 90,
                                  height: 90,
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color.fromRGBO(117, 117, 117, 1),
                                        width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(243, 248, 255, 1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(
                                            0, 4), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/unicef.png"),
                                    ),
                                  )),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class TextContainer extends StatelessWidget {
  const TextContainer(
      {super.key,
      required this.widget,
      required this.goToPage,
      required this.pageNumber});

  final Widget widget;
  final Function(int) goToPage;
  final int pageNumber;

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
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: IconButton(
                onPressed: () {
                  goToPage(pageNumber);
                },
                icon: Icon(Icons.edit)),
          ),
          widget,
        ],
      ),
    );
  }
}

TextStyle H2TextStyle() {
  return TextStyle(
      fontSize: 18,
      color: Color.fromRGBO(52, 77, 87, 1),
      fontWeight: FontWeight.bold);
}
