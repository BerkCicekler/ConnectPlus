import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erasmus_connect/core/app_export.dart';
import 'package:erasmus_connect/models/connect_plus_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EducationCommunityPage extends ConsumerStatefulWidget {
  final Function(int) goToPage;

  const EducationCommunityPage({required this.goToPage, Key? key})
      : super(key: key);

  @override
  EducationCommunityPageState createState() => EducationCommunityPageState();
}

class EducationCommunityPageState
    extends ConsumerState<EducationCommunityPage> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Map<String, dynamic>> likedItems = [];

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _pageController = PageController(initialPage: _currentPage);
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void toggleLike(Map<String, dynamic> itemData) {
    setState(() {
      if (likedItems.contains(itemData)) {
        likedItems.remove(itemData);
      } else {
        likedItems.add(itemData);
      }
    });
  }

  Future<void> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print('Enlem: ${position.latitude}');
      print('Boylam: ${position.longitude}');
    } catch (e) {
      print(e);
    }
  }

  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;

  String _currentAddress = "";
  String _currentAddress2 = "";

  Future<Position> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print('Olmadı :)');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }

  _getAddressFromCoordinates() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentLocation!.latitude, _currentLocation!.longitude);
      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.country}, ${place.subAdministrativeArea}";
        _currentAddress2 = "${place.locality}, ${place.street}";
      });
      print(_currentAddress.toString());
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    ConnectPlusUser user = ref.watch(userProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: MediaQuery.of(context).size.height * 0.12,
          title: Row(
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: user.profilePicture != ""
                    ? Image.network(user.profilePicture.toString(),
                            fit: BoxFit.cover)
                        .image
                    : AssetImage("assets/images/Default_pp.png"),
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context).seninlokasyonun,
                    style: TextStyle(fontSize: 10.0),
                  ),
                  Text(
                    "${_currentAddress}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    "${_currentAddress2}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () async {
                    _currentLocation = await _getCurrentLocation();
                    await _getAddressFromCoordinates();
                    print("${_currentLocation}");
                    print("${_currentAddress}");
                  },
                  icon: Icon(
                    Icons.location_pin,
                    color: Color.fromARGB(255, 0, 186, 186),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 228, 115, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 248, 242),
        body: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return buildMainPage();
                } else if (index == 1) {
                  return buildLikedItemsPage();
                }
                return Container();
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => widget.goToPage(13),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Color.fromARGB(255, 0, 188, 212),
          shape: CircleBorder(),
          elevation: 10,
        ),
      ),
    );
  }

  Widget buildMainPage() {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context).trendler,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: _fireStore
                .collection('events')
                .orderBy('created', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
              final educationCommunityPages = snapshot.data!.docs;

              return ListView.builder(
                itemCount: educationCommunityPages.length,
                itemBuilder: (context, index) {
                  final data = educationCommunityPages[index].data()
                      as Map<String, dynamic>;
                  final date = data['date'] ?? '';
                  final place = data['content'] ?? '';
                  final title = data['title'] ?? '';
                  final time = data['time'] ?? '';
                  // final loggedIn = data['sender'] ?? '';
                  // final currentUser = loggedInUser.email ?? '';
                  final isLiked = likedItems.contains(data);
                  final imageUrls = data['imageUrls'] ?? '';

                  return MessageBubble(
                    date: date,
                    place: place,
                    title: title,
                    time: time,
                    // isLoggedIn: currentUser == loggedIn,
                    isLiked: isLiked,
                    onLikePressed: () => toggleLike(data),
                    imageUrls: imageUrls,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildLikedItemsPage() {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context).favorilerim,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: likedItems.length,
            itemBuilder: (context, index) {
              final data = likedItems[index];
              final date = data['date'] ?? '';
              final place = data['content'] ?? '';
              final title = data['title'] ?? '';
              final time = data['time'] ?? '';
              // final loggedIn = data['sender'] ?? '';
              // final currentUser = loggedInUser.email ?? '';
              final imageUrls = data['imageUrls'] ?? '';

              return MessageBubble(
                date: date,
                place: place,
                title: title,
                time: time,
                // isLoggedIn: currentUser == loggedIn,
                isLiked: true,
                onLikePressed: () => toggleLike(data),
                imageUrls: imageUrls,
              );
            },
          ),
        ),
      ],
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({
    // required this.isLoggedIn,
    required this.isLiked,
    required this.date,
    required this.title,
    required this.time,
    required this.place,
    required this.onLikePressed,
    required this.imageUrls,
  });

  // final bool isLoggedIn;
  final bool isLiked;
  final String date;
  final String title;
  final String time;
  final String place;
  final VoidCallback onLikePressed;
  final String imageUrls;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: ShaderMask(
                shaderCallback: (bound) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color.fromARGB(255, 190, 190, 190).withOpacity(0),
                      Color.fromARGB(255, 133, 133, 133),
                    ],
                  ).createShader(bound);
                },
                blendMode: BlendMode.srcOver,
                child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: Image.network("${imageUrls}").image,
                      fit: BoxFit.cover,
                    ),
                    //tileMode: TileMode.,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.01,
            right: MediaQuery.of(context).size.width * 0.06,
            child: IconButton(
              onPressed: onLikePressed,
              icon: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? Colors.red : Colors.black,
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.02,
            left: MediaQuery.of(context).size.width * 0.06,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Color.fromARGB(0, 0, 0, 0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.black,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Color.fromARGB(255, 0, 186, 186),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          place,
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                blurRadius: 5.0,
                                color: Colors.black,
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '$time $date',
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.black,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/flags_1.png'),
                        radius: 10,
                      ),
                      SizedBox(width: 8),
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/flags_2.png'),
                        radius: 10,
                      ),
                      SizedBox(width: 8),
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/flags_3.png'),
                        radius: 10,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '+5',
                        style: TextStyle(
                          shadows: [
                            Shadow(
                              blurRadius: 5.0,
                              color: Colors.black,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EventCreatorPage extends StatefulWidget {
  final Function(int) goToPage;
  const EventCreatorPage({required this.goToPage, Key? key}) : super(key: key);

  @override
  _EventCreatorPageState createState() => _EventCreatorPageState();
}

class _EventCreatorPageState extends State<EventCreatorPage> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  late String date;
  late String title;
  late String time;
  late String place;
  late TextEditingController dateTextController;
  late TextEditingController placeTextController;
  late TextEditingController titleTextController;
  late TextEditingController timeTextController;

  final picker = ImagePicker();
  PickedFile? _imageFile;
  String? downloadUrl;

  Future chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile != null ? PickedFile(pickedFile.path) : null;
    });
  }

  Future uploadImage() async {
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
      print('Resim yüklendi. İndirme bağlantısı: $downloadUrl');

      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    //retrieveImageUrls();
    dateTextController = TextEditingController();
    placeTextController = TextEditingController();
    titleTextController = TextEditingController();
    timeTextController = TextEditingController();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    dateTextController.dispose();
    placeTextController.dispose();
    titleTextController.dispose();
    timeTextController.dispose();
    super.dispose();
  }

  triggerNotification(String title, String body) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.BigPicture,
        bigPicture: 'asset://assets/images/erasmus_logo.png',
      ),
    );
  }

  void logout() {
    // _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 248, 242),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 34, 24.0, 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 38,
                          width: 38,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: IconButton(
                            onPressed: () {
                              widget.goToPage(12);
                            },
                            icon: Icon(
                              size: 24,
                              CupertinoIcons.chevron_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context).gonderiolustur,
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
                    SizedBox(height: 30.0),
                    buildTextField(
                      controller: titleTextController,
                      hintText: AppLocalizations.of(context).baslik,
                    ),
                    SizedBox(height: 24.0),
                    buildTextField(
                      controller: dateTextController,
                      hintText: AppLocalizations.of(context).tarih,
                    ),
                    SizedBox(height: 24.0),
                    buildTextField(
                      controller: placeTextController,
                      hintText: AppLocalizations.of(context).konum,
                    ),
                    SizedBox(height: 24.0),
                    buildTextField(
                      controller: timeTextController,
                      hintText: AppLocalizations.of(context).saat,
                    ),
                    SizedBox(height: 24.0),
                    GestureDetector(
                      onTap: () {
                        chooseImage();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(180, 183, 111, 40),
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(180, 224, 137, 50),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _imageFile == null
                                ? Text(AppLocalizations.of(context).gorsel,
                                    style: TextStyle(fontSize: 16))
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Image.file(
                                      File(_imageFile!.path),
                                      height: 90,
                                    ),
                                  ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(180, 224, 137, 50)),
                                shadowColor: MaterialStateProperty.all<Color>(
                                    Color.fromARGB(180, 224, 137, 50)),
                              ),
                              onPressed: () {
                                chooseImage();
                              },
                              child: Icon(
                                Icons.add_a_photo,
                                color: Color.fromARGB(255, 135, 69, 2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.0),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 32),
                      child: ElevatedButton(
                        onPressed: () async {
                          await uploadImage();
                          _fireStore.collection('events').add({
                            'date': date,
                            'title': title,
                            'content': place,
                            'time': time,
                            // 'sender': loggedInUser.email,
                            'created': Timestamp.now(),
                            'imageUrls': downloadUrl,
                          });

                          dateTextController.clear();
                          placeTextController.clear();
                          titleTextController.clear();
                          timeTextController.clear();
                          triggerNotification(
                              '${title}', '$place, $date, $time');
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(200, 50),
                          backgroundColor: Color.fromARGB(255, 135, 69, 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context).olustur,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: ElevatedButton(
                        onPressed: () => widget.goToPage(12),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(200, 50),
                          backgroundColor: Color.fromARGB(255, 135, 69, 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context).etkinliklerigoruntule,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
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
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        if (hintText == AppLocalizations.of(context).baslik) {
          title = value;
        } else if (hintText == AppLocalizations.of(context).tarih) {
          date = value;
        } else if (hintText == AppLocalizations.of(context).konum) {
          place = value;
        } else if (hintText == AppLocalizations.of(context).saat) {
          time = value;
        }
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        hintText: hintText,
        filled: true,
        fillColor: Color.fromARGB(180, 224, 137, 50),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide:
              BorderSide(color: const Color.fromARGB(255, 159, 105, 85)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide:
              BorderSide(color: const Color.fromARGB(255, 192, 130, 107)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(color: Color.fromARGB(255, 179, 107, 81)),
        ),
      ),
    );
  }
}
