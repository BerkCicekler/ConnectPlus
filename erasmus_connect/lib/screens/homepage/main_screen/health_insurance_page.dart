import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HealthInsurancePage extends StatefulWidget {
  final Function(int) goToPage;
  const HealthInsurancePage({required this.goToPage, Key? key})
      : super(key: key);

  @override
  _HealthInsurancePageState createState() => _HealthInsurancePageState();
}

class _HealthInsurancePageState extends State<HealthInsurancePage> {
  String selectedCountry = "Türkiye";
  List<String> countries = [
    'Türkiye',
    'İsveç',
    'İtalya',
    'Almanya',
    'Hollanda',
  ];

  Map<String, List<List<String>>> countryCardData = {
    'Türkiye': [
      [
        'assets/images/itu.png',
        'assets/images/odtu.png',
        'assets/images/boun.png',
      ],
      [
        'İstanbul Teknik Üniversitesi',
        'Orta Doğu Teknik Üniversitesi',
        'Boğaziçi Üniversitesi'
      ],
      [
        "Erasmus deneyiminizi İstanbul Teknik Üniversitesi (İTÜ) ile taçlandırın! İTÜ, öğrencilere sağlık sigortası sunmasa da, geniş kampüsü, özgün eğitim programları ve dinamik öğrenci yaşamıyla sizi büyüleyecek bir ortam sunuyor. İTÜ gelen öğrenciler için oluşturulan Erasmus sayfasını ziyaret ederek sağlık sigortası süreçleri, anlaşmalı kurumlar ve gerekliliklerle ilgili daha fazla bilgi edinebilirsiniz.",
        "ODTÜ'nün büyülü atmosferinde unutulmaz bir Erasmus macerasına adım atın! ODTÜ, sağlık sigortası sunmasa da, dünya standartlarında eğitim olanakları, çeşitli sosyal etkinlikler ve etkileyici kampüsü ile öğrencilerine benzersiz bir deneyim sunuyor. ODTÜ gelen öğrenciler için oluşturulan Erasmus sayfasını ziyaret ederek sağlık sigortası süreçleri, anlaşmalı kurumlar ve gerekliliklerle ilgili daha fazla bilgi edinebilirsiniz.",
        "Boğaziçi Üniversitesi'nde Erasmus deneyimi yaşarken hayatınızın en değerli anılarını biriktirin! Boğaziçi Üniversitesi, sağlık sigortası sunmasa da, boğaz manzarası eşliğinde modern eğitim olanakları, uluslararası ortamı ve zengin kültürel etkinlikleriyle sizi büyüleyecek bir ortam sunuyor. Boğaziçi Üniversitesi gelen öğrenciler için oluşturulan Erasmus sayfasını ziyaret ederek sağlık sigortası süreçleri, anlaşmalı kurumlar ve gerekliliklerle ilgili daha fazla bilgi edinebilirsiniz.",
      ],
    ],
    'İsveç': [
      [
        'assets/images/boras.png',
        'assets/images/uppsala.png',
        'assets/images/stockholm.png',
      ],
      [
        'Boras Üniversitesi',
        'Uppsala Üniversitesi',
        'Stockholm Üniversitesi',
      ],
      [
        "İsveç'in gözde şehri Boras'ta unutulmaz bir Erasmus deneyimi yaşayın! Boras Üniversitesi, gelen değişim öğrencilerine ücretsiz sağlık sigortası hizmeti sunmaktadır. Modern kampüsü, çok kültürlü ortamı ve akademik mükemmeliyetiyle size benzersiz bir öğrenme ve keşif fırsatı sunuyor. Boras Üniversitesinden alacak olduğunuz kabul mektubundan sağlık sigortası ile ilgili daha detaylı bilgilere ulaşabilirsiniz. Ayrıca duyurular için Erasmus sayfasını takip etmenizi öneririz.",
        "İsveç'in en eski ve saygın üniversitesi Uppsala'da eşsiz bir akademik deneyim yaşayın! Uppsala Üniversitesi, gelen değişim öğrencilerine sağlık sigortası sunmaktadır. Tarihi atmosferi, dünya standartlarında eğitim imkanları ve renkli öğrenci yaşamıyla sizi büyüleyecek bir ortam sunuyor. Uppsala Üniversitesi Erasmus sayfasını ziyaret ederek sağlık sigortası hakkında daha detaylı  bilgi edinebilirsiniz.",
        "Stockholm Üniversitesi'ndeki değişim öğrencileri, “Kammarkollegiet” tarafından sağlanan, İsveç'teki değişim öğrencileri için İsveç Devleti'nin sigortası olan Student-IN kapsamındadır. Detaylı bilgiye ve sigortanın içeriğine exchange öğrencileri için oluşturulan  bilgiler sayfasından ulaşabilirsiniz. ",
      ],
    ],
    'İtalya': [
      [
        'assets/images/bologna.png',
        'assets/images/milano.png',
        'assets/images/rome.png',
      ],
      [
        'Bologna Üniversitesi',
        'Milano Üniversitesi',
        'Rome La Sapienza Üniversitesi',
      ],
      [
        "İtalya'nın tarihi ve kültürel başkenti Bologna'da eğitim alanında mükemmelliği keşfedin! Köklü geçmişi, üstün akademik kalitesi ve çeşitli fakülteleri ile sizi kucaklayan bir ortam sunmaktadır. Bologna Üniversitesi, gelen değişim öğrencilerine ücretsiz olarak sağlık sigortası sunmaktadır. Bologna Üniversitesi Erasmus sayfasını ziyaret ederek daha fazla bilgi edinebilirsiniz.",
        "Moda ve tasarımın başkenti Milano'da akademik bir deneyim yaşayın! Milano Üniversitesi, sağlık sigortası sunmasa da, kampüsünün merkezi konumu, uluslararası bir öğrenci topluluğu ve önde gelen akademik programları ile size ilham verici bir öğrenme ortamı sunuyor. Milano Üniversitesi Erasmus sayfasına göz atarak daha fazla detaylı bilgi alabilirsiniz.",
        "Eternal City Roma'da unutulmaz bir Erasmus deneyimi yaşayın! Tarihi atmosferi, geniş kampüsü ve çok çeşitli akademik programları ile size benzersiz bir öğrenme ve keşif fırsatı sunuyor. Roma La Sapienza Üniversitesi, sağlık sigortası sunmaktadır. Roma La Sapienza Üniversitesi Erasmus sayfasını ziyaret ederek daha fazla bilgi edinebilirsiniz.",
      ],
    ],
    'Almanya': [
      [
        'assets/images/munih.png',
        'assets/images/berlin.png',
        'assets/images/stuttgart.png',
      ],
      [
        'Münih Teknik Üniversitesi',
        'Berlin Teknik Üniversitesi',
        'Stuttgart Üniversitesi',
      ],
      [
        "Almanya'nın teknoloji ve yenilik merkezi Münih'te kariyerinizi şekillendirin! Mükemmeliyetçilik anlayışıyla ünlü olanakları, dünya çapında tanınan akademisyenleri ve gelişmiş araştırma imkanlarıyla size ilham verici bir öğrenme ortamı sunuyor. Münih Teknik Üniversitesi (TUM), sağlık sigortası konusunda çok katmanlı kurallara sahip. Bu nedenle; TUM Erasmus sayfasına göz atarak daha fazla detaylı bilgi alabilirsiniz.",
        "Teknoloji ve inovasyonun kalbi Berlin'de kariyerinizi şekillendirin! Dünya çapında tanınan mükemmeliyetçilik anlayışı, ileri düzeydeki araştırma olanakları ve uluslararası bir öğrenci topluluğu ile size ilham verici bir öğrenme ortamı sunmaktadır. Berlin Teknik Üniversitesi, sağlık sigortası sunmamaktadır, vize başvurunuzdan önce mutlaka geçerli bir sağlık sigortası yaptırmalısınız. Berlin Teknik Üniversitesi Erasmus sayfasını ziyaret ederek daha fazla bilgi edinebilirsiniz.",
        "Almanya'nın teknoloji ve mühendislik alanında önde gelen üniversitesi Stuttgart'ta kariyerinizi inşa edin! Stuttgart Üniversitesi, sağlık sigortası sunmasa da, mükemmeliyetçilik anlayışı, modern kampüsü ve öğrencilere sunduğu zengin araştırma fırsatları ile size birinci sınıf bir öğrenme deneyimi sunuyor. Stuttgart Üniversitesi Erasmus sayfasına göz atarak daha fazla detaylı bilgi alabilirsiniz.",
      ],
    ],
    'Hollanda': [
      [
        'assets/images/delft.png',
        'assets/images/inholland.png',
        'assets/images/hague.png',
      ],
      [
        'Delft Üniversitesi',
        'Inholland Üniversitesi',
        'Hague Üniversitesi',
      ],
      [
        "Hollanda'nın teknoloji ve mühendislik alanındaki öncü üniversitelerinden biri olan Delft Teknoloji Üniversitesi'nde sınırlarınızı zorlayın! Delft Teknoloji Üniversitesi, sağlık sigortası sunmasa da, International Insurance ile öğrenciler için açısınndan iş birliği içinde. Delft Teknoloji Üniversitesi Erasmus sayfasını ziyaret ederek daha fazla bilgi edinebilirsiniz.",
        "Hollanda'da öğrenme deneyiminizi Inholland Üniversitesi'nde şekillendirin! Inholland Üniversitesi, sağlık sigortası sunmasa da, pratik odaklı eğitim programları, sanayi bağlantıları ve öğrenci merkezli yaklaşımı ile size iş dünyasına hazırlanmak için mükemmel bir ortam sunuyor. Inholland Üniversitesi Erasmus sayfasına göz atarak daha fazla detaylı bilgi alabilirsiniz.",
        "Uluslararası bir ortamda hukuk ve uluslararası ilişkiler alanında uzmanlaşın! Hollanda'nın hukuk başkenti Lahey'de bulunması, uzman öğretim kadrosu ve pratik odaklı eğitim programları ile size kapsamlı bir öğrenme deneyimi sunuyor. The Hague Üniversitesi, gelen değişim öğrencilerine sağlık sigortası sunmaktadır. The Hague Üniversitesi Erasmus sayfasını ziyaret ederek daha fazla bilgi edinebilirsiniz.",
      ],
    ],
  };

  Map<String, List<List<String>>> links = {
    'Türkiye': [
      [
        "erasmus.itu.edu.tr",
        "ico.metu.edu.tr",
        "intl.boun.edu.tr",
      ],
      [
        "Erasmus web sayfası",
        "Erasmus web sayfası",
        "Erasmus web sayfası",
      ],
      [
        "/",
        "/",
        "/",
      ],
    ],
    'İsveç': [
      [
        "www.hb.se",
        "www.uu.se",
        "www.su.se",
      ],
      [
        "Erasmus web sayfası",
        "Erasmus web sayfası",
        "Erasmus web sayfası",
      ],
      [
        "/en/international-student",
        "/en/study/exchange-studies",
        "/english/education/exchange-students"
      ],
    ],
    'İtalya': [
      [
        "www.unibo.it",
        "www.unimi.it",
        "www.uniroma1.it",
      ],
      [
        "Erasmus web sayfası",
        "Erasmus web sayfası",
        "Erasmus web sayfası",
      ],
      [
        "/en/international",
        "/en/international",
        "/en/pagina/erasmus-programme",
      ],
    ],
    'Almanya': [
      [
        "www.mgt.tum.de",
        "www.tu.berlin",
        "www.student.uni-stuttgart.de",
      ],
      [
        "Erasmus web sayfası",
        "Erasmus web sayfası",
        "Erasmus web sayfası",
      ],
      [
        "/programs/international-exchange-programs/incoming-exchange-students",
        "/en/international/students-1/international-students/exchange-studies-at-tu-berlin",
        "/en/study-abroad/exchange",
      ],
    ],
    'Hollanda': [
      [
        "www.tudelft.nl",
        "www.inholland.nl",
        "www.thuas.com",
      ],
      [
        "Erasmus web sayfası",
        "Erasmus web sayfası",
        "Erasmus web sayfası",
      ],
      [
        "/onderwijs/opleidingen/exchange",
        "/inhollandcom/frequently-asked-questions/incoming-exchange-student/",
        "/programmes/exchange-programmes-other-courses/exchange-programmes",
      ],
    ],
  };

  int currentCardIndex = 0;

  void selectCountry(String country) {
    setState(() {
      selectedCountry = country;
      currentCardIndex = 0; // Reset the card index when switching countries
    });
  }

  // Her hangi bir url'i açmak için kullanılabilir.
  Future<void> _launchUrl(String url, String path) async {
    final Uri uri = Uri(scheme: "https", host: url, path: path);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }

  Widget buildCards() {
    List<List<String>> currentCards = countryCardData[selectedCountry]!;
    List<List<String>> link = links[selectedCountry]!;
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      scrollDirection: Axis.horizontal,
      itemCount: currentCards[0].length,
      itemBuilder: (context, index) {
        String imageUrl = currentCards[0][index];
        String frontText = currentCards[1][index];
        String backText = currentCards[2][index];
        String linkText1 = link[0][index];
        String linkText2 = link[1][index];
        String linkText3 = link[2][index];

        return FlipCard(
          front: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 255, 175, 131),
                  Color.fromARGB(255, 118, 61, 31),
                ],
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 255, 156, 102),
                      Color.fromARGB(255, 118, 61, 31),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 48.0, top: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, right: 12.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.sync,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                      _buildCardContent(imageUrl),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          textAlign: TextAlign.center,
                          frontText,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 4,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          back: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 255, 175, 131),
                  Color.fromARGB(255, 118, 61, 31),
                ],
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 255, 175, 131),
                      Color.fromARGB(255, 118, 61, 31),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: backText,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(
                              text: ' ${linkText2}',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color.fromARGB(255, 0, 188, 235),
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _launchUrl(linkText1, linkText3);
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardContent(String imageUrl) {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.5,
      child: Image.asset(
        imageUrl,
        fit: BoxFit.contain,
      ),
    );
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
      body: Column(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: countries.map((country) {
                final isSelected = selectedCountry == country;
                return Padding(
                  padding: EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    onPressed: () => selectCountry(country),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 32.0,
                        ), // Set desired padding here
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        isSelected
                            ? Color.fromARGB(255, 255, 169, 84)
                            : Color.fromARGB(255, 238, 217, 198),
                      ),
                    ),
                    child: Text(
                      country,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? Colors.white
                            : Color.fromARGB(255, 64, 58, 122),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: buildCards(),
          ),
        ],
      ),
    );
  }
}
