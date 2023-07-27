import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VisaPage extends StatelessWidget {
  final Function(int) goToPage;

  const VisaPage({required this.goToPage, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 235, 225),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 255, 248, 242),
        foregroundColor: Color.fromARGB(255, 255, 248, 242),
        surfaceTintColor: Color.fromARGB(255, 255, 248, 242),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
                  goToPage(2);
                },
                icon: Icon(
                  size: 24,
                  CupertinoIcons.chevron_back,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      body: ContainerList(),
    );
  }
}

class ContainerList extends StatelessWidget {
  final List<String> countryNames = [
    'Türkiye',
    'İsveç',
    'İtalya',
    'Almanya',
    'Hollanda'
  ];

  final List<List<String>> visaContent = [
    [
      "Türkiye'ye giriş yapacak Erasmus öğrencileri, Türk Konsolosluğu veya Büyükelçiliği tarafından verilen öğrenci vizesi başvurusunda bulunmalıdır. Başvuru için gerekli belgeler arasında pasaport, kabul mektubu, seyahat sağlık sigortası ve mali durumu gösteren belgeler yer almaktadır.Detaylı bilgilere ",
      "Türk Konsolosluğu/Büyükelçiliği",
      "www.konsolosluk.gov.tr",
      "/",
      " internet sitesinden ulaşabilirsiniz.",
    ],
    [
      "İsveç'e giriş yapacak Erasmus öğrencileri, İsveç Göçmenlik Kurumu (Migrationsverket) tarafından verilen öğrenci vizesi başvurusunda bulunmalıdır. Başvuru için gerekli belgeler arasında pasaport, kabul mektubu, seyahat sağlık sigortası ve mali durumu gösteren belgeler yer almaktadır. Detaylı bilgilere ",
      "İsveç Göçmenlik Kurumu",
      "www.migrationsverket.se",
      "/",
      " internet sitesinden ulaşabilirsiniz.",
    ],
    [
      "İtalya'ya giriş yapacak Erasmus öğrencileri, İtalyan Konsolosluğu veya Büyükelçiliği tarafından verilen öğrenci vizesi başvurusunda bulunmalıdır. Başvuru için gerekli belgeler arasında pasaport, kabul mektubu, seyahat sağlık sigortası ve mali durumu gösteren belgeler yer almaktadır. Vize süreci ve başvuru detayları için ",
      "İtalyan Konsolosluğu/Büyükelçiliği",
      "vistoperitalia.esteri.it",
      "/home/en",
      " internet sitesini ziyaret edebilirsiniz.",
    ],
    [
      "Almanya'ya giriş yapacak Erasmus öğrencileri, Alman Konsolosluğu veya Büyükelçiliği'ne başvurmalı. Gerekli belgeler arasında pasaport, kabul mektubu, seyahat sağlık sigortası ve mali durumu gösteren belgeler bulunmaktadır. Türkiye’de İtalya ve Almanya vize başvuruları için görevlendirilmiş tek kurum olan ",
      "İDATA",
      "www.idata.com.tr",
      "/",
      " üzerinden başvuru yapabilirsiniz.",
    ],
    [
      "Hollanda'ya giriş yapacak Erasmus öğrencileri, Hollanda Göçmenlik ve Vatandaşlık Departmanı (IND) tarafından verilen öğrenci vizesi başvurusunda bulunmalıdır. Başvuru için gereken belgeler arasında pasaport, kabul mektubu, seyahat sağlık sigortası ve mali durumu gösteren belgeler yer almaktadır. (",
      "https://ind.nl/",
      "ind.nl",
      "/",
      " ) Bu site üzerinden Erasmus öğrencileri için vize başvurusuyla ilgili detaylı bilgilere, gerekli belgelere ve başvuru prosedürüne erişebilirsiniz.",
    ],
  ];

  // Her hangi bir url'i açmak için kullanılabilir.
  Future<void> _launchUrl(String url, String path) async {
    final Uri uri = Uri(scheme: "https", host: url, path: path);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage(
                        'assets/images/flags_$index.png',
                      ),
                    ),
                    title: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        countryNames[index],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                  color: Color.fromARGB(255, 255, 144, 34),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(18.0),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: visaContent[index][0].toString(),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: visaContent[index][1].toString(),
                            style: TextStyle(
                              color: Color.fromARGB(255, 66, 139, 193),
                              decoration: TextDecoration.underline,
                              decorationColor:
                                  Color.fromARGB(255, 66, 139, 193),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                await _launchUrl(visaContent[index][2],
                                    visaContent[index][3]);
                              },
                          ),
                          TextSpan(
                            text: visaContent[index][4].toString(),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
