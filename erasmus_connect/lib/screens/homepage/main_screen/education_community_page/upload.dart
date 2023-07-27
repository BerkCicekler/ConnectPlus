import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;
import 'package:uuid/uuid.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  XFile? xfile;
  bool isUploading = false;
  String postId = Uuid().v4();

  final CollectionReference postsRef =
      FirebaseFirestore.instance.collection('posts');

  void handleTakePhoto() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 675,
      maxWidth: 960,
    );
    if (pickedFile != null) {
      setState(() {
        xfile = pickedFile;
      });
    }
    // Use the pickedImage as needed...
  }

  void handleChooseFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 675,
      maxWidth: 960,
    );
    if (pickedFile != null) {
      setState(() {
        xfile = pickedFile;
      });
    }
    // Use the pickedImage as needed...
  }

  selectImage(parentContext) {
    return showDialog(
      context: parentContext,
      builder: (context) {
        return SimpleDialog(
          title: Text('Upload Image'),
          children: [
            SimpleDialogOption(
              child: Text('Photo with Camera'),
              onPressed: () {
                handleTakePhoto();
                Navigator.pop(context);
              },
            ),
            SimpleDialogOption(
              child: Text('Image from Gallery'),
              onPressed: () {
                handleChooseFromGallery();
                Navigator.pop(context);
              },
            ),
            SimpleDialogOption(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  clearImage() {
    setState(() {
      xfile = null;
    });
  }

  Future<String> uploadImage(File imageFile) async {
    final storageRef = FirebaseStorage.instance.ref().child('post_$postId.jpg');
    final uploadTask = storageRef.putFile(imageFile);
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  createPostInFirestore({
    required String mediaUrl,
    required String title,
    required String location,
    required String time,
  }) async {
    await postsRef.doc(postId).set({
      "postId": postId,
      "mediaUrl": mediaUrl,
      "title": title,
      "location": location,
      "time": time,
      "participants": {},
    });
  }

  handleSubmit() async {
    setState(() {
      isUploading = true;
    });
    await compressImage();
    if (xfile != null) {
      File imageFile = File(xfile!.path);
      String mediaUrl = await uploadImage(imageFile);
      createPostInFirestore(
        mediaUrl: mediaUrl,
        title: titleController.text,
        location: locationController.text,
        time: timeController.text,
      );
      titleController.clear();
      timeController.clear();
      locationController.clear();
      setState(() {
        xfile = null;
        isUploading = false;
      });
    }
  }

  compressImage() async {
    if (xfile != null) {
      final tempDir = await getTemporaryDirectory();
      final path = tempDir.path;
      List<int> bytes = await xfile!.readAsBytes();
      Uint8List uint8List = Uint8List.fromList(bytes);
      Im.Image? imageFile = Im.decodeImage(uint8List);
      final compressedImageFile = File('$path/img_$postId.jpg')
        ..writeAsBytesSync(Im.encodeJpg(imageFile!, quality: 75));
      setState(() {
        xfile = compressedImageFile as XFile?;
      });
    } else {
      // Handle the case when xfile is null
    }
  }

  Widget buildUploadForm() {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(
          'Caption Post',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          FloatingActionButton(
            onPressed: isUploading ? null : () => handleSubmit(),
            child: Text(
              'Post',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: [
            isUploading ? LinearProgressIndicator() : Text(''),
            xfile == null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 120),
                    child: ElevatedButton(
                      onPressed: () => selectImage(context),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                      child: Icon(Icons.add_a_photo),
                    ),
                  )
                : Container(
                    height: 220.0,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                File(xfile!.path),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: 20.0,
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                    'https://i.pravatar.cc/150?img=3'),
              ),
              title: Container(
                width: 250.0,
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Event title',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.calendar_today,
                color: Colors.orange,
                size: 35.0,
              ),
              title: Container(
                width: 250.0,
                child: TextField(
                  controller: timeController,
                  decoration: InputDecoration(
                    hintText: 'Event time',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.pin_drop,
                color: Colors.orange,
                size: 35.0,
              ),
              title: Container(
                width: 250.0,
                child: TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    hintText: 'Event location',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Container(
              width: 200.0,
              height: 100.0,
              alignment: Alignment.center,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.my_location,
                  color: Colors.white,
                ),
                label: Text(
                  'Konum Ekle',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildUploadForm();
  }
}
