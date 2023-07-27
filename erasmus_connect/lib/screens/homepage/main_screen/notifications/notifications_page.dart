import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  final Function(int) goToPage;

  const NotificationsPage({required this.goToPage, Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 235, 225),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(128, 255, 144, 34),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  widget.goToPage(2);
                },
                child: Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Icon(
                    CupertinoIcons.chevron_back,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: Text(
                  'Bildirimler',
                  style: TextStyle(
                    color: Color.fromARGB(255, 64, 58, 122),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                CupertinoIcons.chevron_back,
                color: Colors.transparent,
              ),
            ],
          ),
        ),
        body: FutureBuilder<List<QuerySnapshot>>(
          future: getCollectionData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            final events = snapshot.data?[0].docs;
            final bogaziciDocs = snapshot.data?[1].docs;
            final ituDocs = snapshot.data?[2].docs;
            final odtuDocs = snapshot.data?[3].docs;
            final borasDocs = snapshot.data?[4].docs;
            final uppsalaDocs = snapshot.data?[5].docs;
            final stockholmDocs = snapshot.data?[6].docs;
            final bolognaDocs = snapshot.data?[7].docs;
            final milanoDocs = snapshot.data?[8].docs;
            final romeLaDocs = snapshot.data?[9].docs;
            final munihDocs = snapshot.data?[10].docs;
            final berlinDocs = snapshot.data?[11].docs;
            final stuttgartDocs = snapshot.data?[12].docs;
            final delftDocs = snapshot.data?[13].docs;
            final inhollandDocs = snapshot.data?[14].docs;
            final hagueDocs = snapshot.data?[15].docs;

            final allDocs = [
              ...events!,
              ...bogaziciDocs!,
              ...ituDocs!,
              ...odtuDocs!,
              ...borasDocs!,
              ...uppsalaDocs!,
              ...stockholmDocs!,
              ...bolognaDocs!,
              ...milanoDocs!,
              ...romeLaDocs!,
              ...munihDocs!,
              ...berlinDocs!,
              ...stuttgartDocs!,
              ...delftDocs!,
              ...inhollandDocs!,
              ...hagueDocs!
            ];

            allDocs.sort((a, b) => (b['created'] as Timestamp)
                .compareTo(a['created'] as Timestamp));

            return ListView.separated(
              itemCount: allDocs.length,
              separatorBuilder: (context, index) => Divider(
                indent: 20,
                endIndent: 25,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              itemBuilder: (context, index) {
                final doc = allDocs[index];
                final collectionPath = doc.reference.parent?.path;
                final collectionName = collectionPath?.split('/').first ?? '';

                final place = doc['content'] as String? ?? '';
                final time = doc['time'] as String? ?? '';
                final eventTitle = doc['title'] as String? ?? '';
                final date = doc['date'] as String? ?? '';

                return ListTile(
                  leading: getIconForCollection(collectionName),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        eventTitle,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  subtitle: time != ''
                      ? Text(
                          'Place: $place\nDate: $date',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 118, 118, 118),
                          ),
                        )
                      : Text(
                          '$place',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 118, 118, 118),
                          ),
                        ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<List<QuerySnapshot>> getCollectionData() async {
    final eventsSnapshot = FirebaseFirestore.instance
        .collection('events')
        .orderBy('created', descending: true)
        .get();

    final bogaziciSnapshot =
        FirebaseFirestore.instance.collection('Boğaziçi Üniversitesi').get();

    final ituSnapshot = FirebaseFirestore.instance
        .collection('İstanbul Teknik Üniversitesi')
        .get();

    final odtuSnapshot = FirebaseFirestore.instance
        .collection('Orta Doğu Teknik Üniversitesi')
        .get();
    final borasSnapshot =
        FirebaseFirestore.instance.collection('Boras Üniversitesi').get();
    final uppsalaSnapshot =
        FirebaseFirestore.instance.collection('Uppsala Üniversitesi').get();
    final stockholmSnapshot =
        FirebaseFirestore.instance.collection('Stockholm Üniversitesi').get();
    final bolognaSnapshot =
        FirebaseFirestore.instance.collection('Bologna Üniversitesi').get();
    final milanoSnapshot =
        FirebaseFirestore.instance.collection('Milano Üniversitesi').get();
    final romeLaSnapshot = FirebaseFirestore.instance
        .collection('Rome La Sapienza Üniversitesi')
        .get();
    final munihSnapshot =
        FirebaseFirestore.instance.collection('Münih Üniversitesi').get();
    final berlinSnapshot =
        FirebaseFirestore.instance.collection('Berlin Üniversitesi').get();
    final stuttgartSnapshot =
        FirebaseFirestore.instance.collection('Stuttgart Üniversitesi').get();
    final delftSnapshot =
        FirebaseFirestore.instance.collection('Delft Üniversitesi').get();
    final inhollandSnapshot =
        FirebaseFirestore.instance.collection('Inholland Üniversitesi').get();
    final hagueSnapshot =
        FirebaseFirestore.instance.collection('Hague Üniversitesi').get();

    return await Future.wait([
      eventsSnapshot,
      bogaziciSnapshot,
      ituSnapshot,
      odtuSnapshot,
      borasSnapshot,
      uppsalaSnapshot,
      stockholmSnapshot,
      bolognaSnapshot,
      milanoSnapshot,
      romeLaSnapshot,
      munihSnapshot,
      berlinSnapshot,
      stuttgartSnapshot,
      delftSnapshot,
      inhollandSnapshot,
      hagueSnapshot
    ]);
  }

  Icon getIconForCollection(String collectionName) {
    if (collectionName == 'events') {
      return Icon(Icons.favorite, color: Colors.red);
    } else if (collectionName == 'Boğaziçi Üniversitesi') {
      return Icon(Icons.chat);
    } else if (collectionName == 'community') {
      return Icon(Icons.group);
    } else {
      return Icon(Icons.people_alt_rounded);
    }
  }
}
