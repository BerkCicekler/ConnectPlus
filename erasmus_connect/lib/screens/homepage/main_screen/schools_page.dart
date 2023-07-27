import 'package:erasmus_connect/screens/homepage/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SchoolsPage extends StatefulWidget {
  final Function(int) goToPage;
  const SchoolsPage({required this.goToPage, Key? key}) : super(key: key);

  @override
  _SchoolsPageState createState() => _SchoolsPageState();
}

class _SchoolsPageState extends State<SchoolsPage> {
  List<bool> dropdownOpenState = [false, false, false, false, false];

  final List<String> images = [];

  final List<String> countryNames = [
    'Türkiye',
    'İsveç',
    'İtalya',
    'Almanya',
    'Hollanda'
  ];

  List<List<List<String>>> universityContent = [
    [
      [
        "İstanbul Teknik Üniversitesi (İTÜ) Erasmus Programı, öğrencilere uluslararası öğrenci değişimi fırsatı sunar. İTÜ'nün resmi Erasmus web sayfası üzerinden başvuru süreci, destek ve danışmanlık, Erasmus hibe ve bursları ile Erasmus ortak üniversiteleri hakkında ayrıntılı bilgilere ulaşabilirsiniz. İlgili link için ",
        "buraya tıklayabilirsiniz.",
        "erasmus.itu.edu.tr",
        "",
        "",
      ],
      [
        "Orta Doğu Teknik Üniversitesi (ODTÜ), öğrencilere Erasmus Programı aracılığıyla uluslararası öğrenci değişimi fırsatı sunmaktadır. ODTÜ'nün resmi Erasmus web sayfası üzerinden başvuru süreci, destek ve danışmanlık, Erasmus hibe ve bursları ile ODTÜ'nün Erasmus anlaşması olan üniversiteler hakkında detaylı bilgilere ulaşabilirsiniz. İlgili link için ",
        "buraya tıklayabilirsiniz.",
        "ico.metu.edu.tr",
        "",
        "",
      ],
      [
        "Boğaziçi Üniversitesi, öğrencilere Erasmus Programı ile uluslararası öğrenci değişimi imkanı sunmaktadır. Boğaziçi Üniversitesi'nin resmi ",
        "Erasmus web sayfası",
        "intl.boun.edu.tr",
        " üzerinden başvuru süreci, destek ve danışmanlık, Erasmus hibe ve bursları ile Boğaziçi Üniversitesi'nin Erasmus anlaşması bulunan üniversiteler hakkında ayrıntılı bilgilere ulaşabilirsiniz.",
        "/",
      ],
    ],
    [
      [
        "Boras Üniversitesi, öğrencilere Erasmus Programı ile uluslararası öğrenci değişimi fırsatı sunmaktadır. Boras Üniversitesi'nin resmi Erasmus web sayfası üzerinden başvuru süreci, destek ve danışmanlık, Erasmus hibe ve bursları ile Boras Üniversitesi'nin Erasmus anlaşması bulunan üniversiteler hakkında ayrıntılı bilgilere ulaşabilirsiniz. İlgili link için ",
        "buraya tıklayabilirsiniz.",
        "www.hb.se",
        "",
        "/en/international-student",
      ],
      [
        "Uppsala Üniversitesi, öğrencilere Erasmus Programı ile uluslararası öğrenci değişimi fırsatı sunmaktadır. Uppsala Üniversitesi'nin resmi Erasmus web sayfası üzerinden başvuru süreci, destek ve danışmanlık, Erasmus hibe ve bursları ile Uppsala Üniversitesi'nin Erasmus anlaşması bulunan üniversiteler hakkında ayrıntılı bilgilere ulaşabilirsiniz. İlgili link için ",
        "buraya tıklayabilirsiniz.",
        "www.uu.se",
        "",
        "/en/study/exchange-studies",
      ],
      [
        "Stockholm Üniversitesi, Erasmus Programı aracılığıyla uluslararası öğrencilere değişim fırsatı sunmaktadır. Stockholm Üniversitesi'nin resmi Erasmus web sayfası üzerinden başvuru süreci, destek ve danışmanlık hizmetleri, Erasmus hibe ve burs olanakları ile Stockholm Üniversitesi'nin Erasmus anlaşması bulunan diğer üniversiteler hakkında ayrıntılı bilgilere erişebilirsiniz. İlgili linke ",
        "buradan ulaşabilirsiniz",
        "www.su.se",
        "",
        "/english/education/exchange-students",
      ],
    ],
    [
      [
        "Bologna Üniversitesi, uluslararası öğrencilere Erasmus Programı ile değişim imkanı sunmaktadır. Bologna Üniversitesi'nin resmi Erasmus web sayfası üzerinden başvuru süreci, danışmanlık ve destek hizmetleri, Erasmus hibe ve bursları ile Bologna Üniversitesi'nin Erasmus anlaşması bulunan üniversiteler hakkında detaylı bilgilere ulaşabilirsiniz. İlgili link için ",
        "buraya tıklayabilirsiniz.",
        "www.unibo.it",
        "",
        "/en/international",
      ],
      [
        "Milano Üniversitesi, uluslararası öğrencilere Erasmus Programı aracılığıyla değişim fırsatı sunmaktadır. Milano Üniversitesi'nin resmi Erasmus web sayfası üzerinden başvuru süreci, destek ve danışmanlık hizmetleri, Erasmus hibe ve bursları ile Milano Üniversitesi'nin Erasmus anlaşması bulunan üniversiteler hakkında ayrıntılı bilgilere erişebilirsiniz. İlgili link için ",
        "buraya tıklayabilirsiniz.",
        "www.unimi.it",
        "",
        "/en/international",
      ],
      [
        "Roma La Sapienza Üniversitesi, Erasmus Programı kapsamında uluslararası öğrencilere değişim imkanı sunmaktadır. Roma La Sapienza Üniversitesi'nin resmi Erasmus web sayfası üzerinden başvuru süreci, destek ve danışmanlık hizmetleri, Erasmus hibe ve bursları ile Roma La Sapienza Üniversitesi'nin Erasmus anlaşması bulunan üniversiteler hakkında detaylı bilgilere ulaşabilirsiniz. İlgili link için ",
        "buraya tıklayabilirsiniz.",
        "www.uniroma1.it",
        "",
        "/en/pagina/erasmus-programme",
      ],
    ],
    [
      [
        "Münih Teknik Üniversitesi (Technical University of Munich), mükemmeliyetçilik ve yenilikçilik anlayışıyla öne çıkan, dünya çapında saygın bir üniversitedir. Erasmus Programı ile Münih Teknik Üniversitesi'nin sunduğu eğitim imkanlarından yararlanabilirsiniz. Münih Teknik Üniversitesi'nin resmi ",
        "Erasmus web sayfası",
        "www.mgt.tum.de",
        " üzerinden başvuru süreci, destek ve danışmanlık hizmetleri, Erasmus hibe ve burs olanakları hakkında ayrıntılı bilgilere ulaşabilirsiniz. Üniversitenin farklı bölümleri, programları ve araştırma imkanları hakkında daha fazla bilgi edinebilirsiniz.",
        "/programs/international-exchange-programs/incoming-exchange-students",
      ],
      [
        "Berlin Teknik Üniversitesi'nin resmi ",
        "Erasmus web sayfası",
        "www.tu.berlin",
        " üzerinden başvuru süreci, destek ve danışmanlık hizmetleri, Erasmus hibe ve burs olanakları hakkında ayrıntılı bilgilere ulaşabilirsiniz. Üniversitenin farklı fakülteleri, programları ve araştırma projeleri hakkında daha fazla bilgi edinebilirsiniz. Erasmus öğrencileri, Berlin Teknik Üniversitesi'nin dinamik ve çeşitli akademik ortamında eğitim alabilir, uluslararası öğrenci topluluğuyla etkileşimde bulunabilirler. Berlin şehri ise sanat, kültür ve tarih açısından zengin bir merkez olup öğrencilere eşsiz bir deneyim sunmaktadır.",
        "/en/international/students-1/international-students/exchange-studies-at-tu-berlin",
      ],
      [
        "Stuttgart Üniversitesi'nin resmi ",
        "Erasmus web sayfası",
        "www.student.uni-stuttgart.de",
        " üzerinden başvuru süreci, destek ve danışmanlık hizmetleri, Erasmus hibe ve burs olanakları hakkında ayrıntılı bilgilere ulaşabilirsiniz. Üniversitenin çeşitli fakülteleri, programları ve araştırma projeleri hakkında daha fazla bilgi edinebilirsiniz. Stuttgart Üniversitesi'nde geçireceğiniz Erasmus dönemi, akademik gelişiminizin yanı sıra farklı kültürleri tanıma ve yeni deneyimler kazanma fırsatı sunacaktır.",
        "/en/study-abroad/exchange",
      ],
    ],
    [
      [
        "Delft Üniversitesi, Hollanda'nın Delft şehrinde yer alan dünyaca ünlü bir üniversitedir. Yüksek kaliteli eğitim ve araştırma imkanları sunan Delft Üniversitesi, uluslararası öğrencilere de çeşitli olanaklar sağlamaktadır. Delft Üniversitesi'nin resmi ",
        "Erasmus web sayfası",
        "www.tudelft.nl",
        " başvuru süreci, kabul kriterleri ve önemli tarihler gibi ayrıntılı bilgilere erişebileceğiniz bir kaynaktır. Bu sayfada, uluslararası öğrencilerin nasıl başvuruda bulunabilecekleri, başvuru sürecinin adımları, başvuru takvimi gibi konular hakkında bilgiler bulunmaktadır.",
        "/onderwijs/opleidingen/exchange",
      ],
      [
        "Inholland Üniversitesi, Hollanda genelinde farklı şehirlerde bulunan bir uygulamalı bilimler üniversitesidir. Yüksek kaliteli eğitim ve pratik odaklı programlarıyla bilinir. Inholland Üniversitesi, uluslararası öğrencilere Erasmus Programı aracılığıyla eğitim alma fırsatı sunmaktadır.Inholland Üniversitesi'nin resmi ",
        "Erasmus web sayfası",
        "www.inholland.nl",
        "başvuru süreci, akademik programlar, kabul koşulları ve diğer önemli bilgiler hakkında ayrıntılı bilgiler içermektedir.",
        "/inhollandcom/frequently-asked-questions/incoming-exchange-student/"
      ],
      [
        "The Hague Üniversitesi Hague'da yer alan bir üniversitedir. Uluslararası öğrencilere geniş bir yelpazede programlar sunmaktadır. The Hague Üniversitesi de Erasmus Programı aracılığıyla uluslararası öğrencilere eğitim alma imkanı sunan kurumlardan biridir. The Hague Üniversitesi'nin resmi ",
        "Erasmus web sayfası",
        "www.thuas.com",
        " başvuru süreci, program seçenekleri, akademik takvim ve diğer önemli bilgilerle ilgili detaylı bilgiler içermektedir. Bu sayfada, başvuru koşulları, belgeler, başvuru takvimi gibi konular hakkında ayrıntılı bilgiler bulunmaktadır.",
        "/programmes/exchange-programmes-other-courses/exchange-programmes",
      ],
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
                  widget.goToPage(2);
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
      backgroundColor: Color.fromARGB(255, 255, 248, 242),
      body: ListView(
        children: [
          SizedBox(height: 30),
          buildDivider(),
          buildDropdownMenu(0, 'İstanbul Teknik Üniversitesi',
              'Orta Doğu Teknik Üniversitesi', 'Boğaziçi Üniversitesi'),
          buildDivider(),
          SizedBox(height: 20),
          buildDivider(),
          buildDropdownMenu(1, 'Boras Üniversitesi', 'Uppsala Üniversitesi',
              'Stockholm Üniversitesi'),
          buildDivider(),
          SizedBox(height: 20),
          buildDivider(),
          buildDropdownMenu(2, 'Bologna Üniversitesi', 'Milano Üniversitesi',
              'Rome La Sapienza Üniversitesi'),
          buildDivider(),
          SizedBox(height: 20),
          buildDivider(),
          buildDropdownMenu(3, 'Münih Teknik Üniversitesi',
              'Berlin Teknik Üniversitesi', 'Stuttgart Üniversitesi'),
          buildDivider(),
          SizedBox(height: 20),
          buildDivider(),
          buildDropdownMenu(4, 'Delft Üniversitesi', 'Inholland Üniversitesi',
              'Hague Üniversitesi'),
          buildDivider(),
        ],
      ),
    );
  }

  Widget buildDropdownMenu(
      int index, String option1, String option2, String option3) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(
              'assets/images/flags_$index.png',
            ),
          ),
          title: Align(
            alignment: Alignment.center,
            child: Text(
              countryNames[index],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          trailing: Icon(
            dropdownOpenState[index]
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down,
            color: Colors.black,
          ),
          onTap: () {
            setState(() {
              dropdownOpenState[index] = !dropdownOpenState[index];
            });
          },
        ),
        if (dropdownOpenState[index]) ...[
          buildElevatedButton(option1, countryNames[index], index, 0, 0),
          buildElevatedButton(option2, countryNames[index], index, 1, 0),
          buildElevatedButton(option3, countryNames[index], index, 2, 0),
        ],
      ],
    );
  }

  Widget buildElevatedButton(
      String text, String countryName, int index, int text1, int text2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width * 0.9,
        child: ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 60),
                  child: AlertDialog(
                    contentPadding: EdgeInsets.all(24),
                    backgroundColor: Color.fromARGB(255, 189, 104, 28),
                    content: SingleChildScrollView(
                      child: Container(
                        width: double.maxFinite,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              text,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: universityContent[index][text1]
                                                  [text2]
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        TextSpan(
                                          text: universityContent[index][text1]
                                                  [text2 + 1]
                                              .toString(),
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 66, 139, 193),
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: Color.fromARGB(
                                                255, 66, 139, 193),
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () async {
                                              await _launchUrl(
                                                  universityContent[index]
                                                      [text1][text2 + 2],
                                                  universityContent[index]
                                                      [text1][text2 + 4]);
                                            },
                                        ),
                                        TextSpan(
                                          text: universityContent[index][text1]
                                                  [text2 + 3]
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.white,
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
                      ),
                    ),
                  ),
                );
              },
            );
          },
          icon: Icon(Icons.check, color: Colors.transparent),
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.arrow_circle_right_outlined,
                color: Colors.black,
                size: 30,
              ),
            ],
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 252, 198, 54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDivider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: Divider(
        color: Colors.black,
        thickness: 1,
      ),
    );
  }
}
