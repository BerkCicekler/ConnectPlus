import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommunitiesPage extends StatefulWidget {
  final Function(int) goToPage;
  const CommunitiesPage({required this.goToPage, Key? key}) : super(key: key);

  @override
  State<CommunitiesPage> createState() => _CommunitiesPageState();
}
//----------------------------------------------------------------------------------------------------

class _CommunitiesPageState extends State<CommunitiesPage> {
  final List<School> schools = [
    School(
      title: 'İstanbul Teknik Üniversitesi',
      country: 'Türkiye',
      joinedPeople: 50,
      avatarUrls: [
        'assets/images/community_detail_img_1.png',
        'assets/images/community_img_4.png',
        'assets/images/community_img_5.png',
      ],
    ),
    School(
      title: 'Orta Doğu Teknik Üniversitesi',
      country: 'Türkiye',
      joinedPeople: 30,
      avatarUrls: [
        'assets/images/community_detail_img_2.png',
        'assets/images/community_img_4.png',
        'assets/images/community_img_5.png',
      ],
    ),
    School(
      title: 'Boğaziçi Üniversitesi',
      country: 'Türkiye',
      joinedPeople: 20,
      avatarUrls: [
        'assets/images/community_detail_img_3.png',
        'assets/images/community_img_4.png',
        'assets/images/community_img_5.png',
      ],
    ),
    School(
      title: 'Boras Üniversitesi',
      country: 'İsveç',
      joinedPeople: 50,
      avatarUrls: [
        'assets/images/community_detail_img_4.png',
        'assets/images/community_img_4.png',
        'assets/images/community_img_5.png',
      ],
    ),
    School(
      title: 'Uppsala Üniversitesi',
      country: 'İsveç',
      joinedPeople: 30,
      avatarUrls: [
        'assets/images/community_detail_img_5.png',
        'assets/images/community_img_4.png',
        'assets/images/community_img_5.png',
      ],
    ),
    School(
      title: 'Stockholm Üniversitesi',
      country: 'İsveç',
      joinedPeople: 20,
      avatarUrls: [
        'assets/images/community_detail_img_6.png',
        'assets/images/community_img_4.png',
        'assets/images/community_img_5.png',
      ],
    ),
    School(
      title: 'Bologna Üniversitesi',
      country: 'İtalya',
      joinedPeople: 50,
      avatarUrls: [
        'assets/images/community_detail_img_7.png',
        'assets/images/community_img_4.png',
        'assets/images/community_img_5.png',
      ],
    ),
    School(
      title: 'Milano Üniversitesi',
      country: 'İtalya',
      joinedPeople: 30,
      avatarUrls: [
        'assets/images/community_detail_img_8.png',
        'assets/images/community_img_4.png',
        'assets/images/community_img_5.png',
      ],
    ),
    School(
      title: 'Rome La Sapienza Üniversitesi',
      country: 'İtalya',
      joinedPeople: 20,
      avatarUrls: [
        'assets/images/community_detail_img_9.png',
        'assets/images/community_img_4.png',
        'assets/images/community_img_5.png',
      ],
    ),
    School(
      title: 'Münih Teknik Üniversitesi',
      country: 'Almanya',
      joinedPeople: 50,
      avatarUrls: [
        'assets/images/community_detail_img_10.png',
        'assets/images/community_img_4.png',
        'assets/images/community_img_5.png',
      ],
    ),
    School(
      title: 'Berlin Teknik Üniversitesi',
      country: 'Almanya',
      joinedPeople: 30,
      avatarUrls: [
        'assets/images/community_detail_img_11.png',
        'assets/images/community_img_4.png',
        'assets/images/community_img_5.png',
      ],
    ),
    School(
      title: 'Stuttgart Üniversitesi',
      country: 'Almanya',
      joinedPeople: 20,
      avatarUrls: [
        'assets/images/community_detail_img_12.png',
        'assets/images/community_img_4.png',
        'assets/images/community_img_5.png',
      ],
    ),
    School(
      title: 'Delft Üniversitesi',
      country: 'Hollanda',
      joinedPeople: 50,
      avatarUrls: [
        'assets/images/community_detail_img_13.png',
        'assets/images/community_img_4.png',
        'assets/images/community_img_5.png',
      ],
    ),
    School(
      title: 'Inholland Üniversitesi',
      country: 'Hollanda',
      joinedPeople: 30,
      avatarUrls: [
        'assets/images/community_detail_img_14.png',
        'assets/images/community_img_4.png',
        'assets/images/community_img_5.png',
      ],
    ),
    School(
      title: 'Hague Üniversitesi',
      country: 'Hollanda',
      joinedPeople: 20,
      avatarUrls: [
        'assets/images/community_detail_img_15.png',
        'assets/images/community_img_4.png',
        'assets/images/community_img_5.png',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 247, 235, 225),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(128, 255, 144, 34),
          foregroundColor: const Color.fromARGB(128, 255, 144, 34),
          surfaceTintColor: const Color.fromARGB(128, 255, 144, 34),
          shadowColor: const Color.fromARGB(128, 255, 144, 34),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: IconButton(
                  onPressed: () {
                    widget.goToPage(2);
                  },
                  icon: Icon(
                    Icons.chevron_left,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                AppLocalizations.of(context).topluluklar,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.search,
                color: Colors.black,
              ),
            ],
          ),
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(12.0),
          itemCount: schools.length,
          itemBuilder: (BuildContext context, int index) {
            return ContainerCard(
              school: schools[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CommunityDetailsPage(school: schools[index]),
                  ),
                );
                print("index ===== >$index");
                print("school ===== >${schools[index]}");
              },
            );
          },
        ),
      ),
    );
  }
}

class School {
  final String title;
  final String country;
  final int joinedPeople;
  final List<String> avatarUrls;

  School({
    required this.title,
    required this.country,
    required this.joinedPeople,
    required this.avatarUrls,
  });
}

class ContainerCard extends StatelessWidget {
  final School school;
  final VoidCallback onTap;

  ContainerCard({required this.school, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(90.0),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage(
                school.avatarUrls[0],
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    school.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    school.country,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: const Color.fromARGB(255, 106, 106, 106),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(
                        Size(100, 20),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 81, 129, 184),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    onPressed: onTap,
                    child: Text(
                      AppLocalizations.of(context).katil,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage(school.avatarUrls[1]),
                      ),
                      SizedBox(width: 5.0),
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage(school.avatarUrls[2]),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        '${school.joinedPeople} ${AppLocalizations.of(context).katildi}',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommunityDetailsPage extends StatefulWidget {
  final School school;

  CommunityDetailsPage({required this.school});

  @override
  State<CommunityDetailsPage> createState() => _CommunityDetailsPageState();
}

class _CommunityDetailsPageState extends State<CommunityDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color.fromARGB(255, 255, 248, 242),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset(
                  widget.school.avatarUrls[0],
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Container(
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
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        size: 24,
                        CupertinoIcons.chevron_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              color: Color.fromARGB(255, 251, 188, 127),
              child: Column(
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    widget.school.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color.fromARGB(153, 184, 101, 18),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.school.country,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            ),
                            Text(
                              ' / ${widget.school.joinedPeople} ${AppLocalizations.of(context).uye}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color.fromARGB(153, 184, 101, 18),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context).topluluktanayrilin,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ),
                              ),
                              SizedBox(width: 5.0),
                              Icon(
                                Icons.exit_to_app,
                                color: Colors.white,
                                size: 12.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(widget.school.title)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final posts = snapshot.data!.docs.map((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        return Post(
                          id: doc.id,
                          created: data['created'],
                          date: data['date'],
                          title: data['title'],
                          content: data['content'],
                          imageUrl: data['imageUrl'],
                          comments: data['comments'],
                          upvotes: data['upvotes'],
                          time: data['time'],
                        );
                      }).toList();

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: posts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return PostCard(post: posts[index]);
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the create post page
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreatePostPage(school: widget.school)),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 0, 188, 212),
        shape: CircleBorder(),
        elevation: 10,
      ),
    );
  }
}

class Post {
  final String id;
  final Timestamp created;
  final String date;
  final String title;
  final String content;
  final String imageUrl;
  final int comments;
  final int upvotes;
  final String time;

  Post({
    required this.id,
    required this.created,
    required this.date,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.comments,
    required this.upvotes,
    required this.time,
  });
}

class PostCard extends StatefulWidget {
  final Post post;

  PostCard({required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  String formatDuration(Duration duration) {
    if (duration.inDays >= 1) {
      return '${duration.inDays} ${AppLocalizations.of(context).gunonce}';
    } else if (duration.inHours >= 1) {
      return '${duration.inHours} ${AppLocalizations.of(context).saatonce}';
    } else if (duration.inMinutes >= 1) {
      return '${duration.inMinutes} ${AppLocalizations.of(context).dakikaonce}';
    } else {
      return '${AppLocalizations.of(context).simdi}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Duration timeDifference =
        DateTime.now().difference(widget.post.created.toDate());
    final String elapsedTime = formatDuration(timeDifference);
    return Container(
      margin: EdgeInsets.all(10.0),
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                widget.post.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Container at the bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 252, 198, 54),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Content
                  Text(
                    widget.post.content,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  // Time
                  Text(
                    elapsedTime, // Replace with the actual time
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.thumb_up,
                        color: Colors.black,
                        size: 20.0,
                      ),
                      Icon(
                        Icons.comment,
                        color: Colors.black,
                        size: 20.0,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CreatePostPage extends StatefulWidget {
  final School school;

  const CreatePostPage({super.key, required this.school});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _postTitle = '';
  String _postContent = '';
  String _postImageUrl = '';

  final picker = ImagePicker();
  PickedFile? _imageFile;
  String downloadUrl = '';

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
      print('Image uploaded. Download URL: $downloadUrl');

      setState(() {});
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 248, 242),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 34, 24.0, 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                Navigator.pop(context);
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
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context).baslik,
                          filled: true,
                          fillColor: Color.fromARGB(180, 224, 137, 50),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                                color: const Color.fromARGB(255, 159, 105, 85)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                                color:
                                    const Color.fromARGB(255, 192, 130, 107)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 179, 107, 81)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _postTitle = value ?? '';
                        },
                      ),
                      SizedBox(height: 24.0),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context).icerik,
                          filled: true,
                          fillColor: Color.fromARGB(180, 224, 137, 50),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                                color: const Color.fromARGB(255, 159, 105, 85)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                                color:
                                    const Color.fromARGB(255, 192, 130, 107)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 179, 107, 81)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen içerik giriniz';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _postContent = value ?? '';
                        },
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
                                          vertical: 10),
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 32),
                        child: ElevatedButton(
                          onPressed: () async {
                            await uploadImage();
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              // Create a new Post object
                              final post = Post(
                                title: _postTitle,
                                created: Timestamp.now(),
                                date: '',
                                content: _postContent,
                                imageUrl: downloadUrl,
                                comments: 0,
                                upvotes: 0,
                                time: '',
                                id: '',
                              );

                              // Save the post to Firebase
                              savePostToFirebase(post);

                              // Reset the form
                              _formKey.currentState!.reset();
                              triggerNotification(
                                  '${widget.school.title} ${_postTitle}',
                                  '$_postContent');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(300, 50),
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

  void savePostToFirebase(Post post) {
    final communityCollection =
        FirebaseFirestore.instance.collection(widget.school.title);

    communityCollection.add({
      'title': post.title,
      'created': post.created,
      'date': post.date,
      'content': post.content,
      'imageUrl': post.imageUrl,
      'comments': post.comments,
      'upvotes': post.upvotes,
      'time': post.time,
    }).then((value) {
      print('Firebase eklendi');
    }).catchError((error) {
      print('Hata: $error');
    });
  }
}
