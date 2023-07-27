import 'package:erasmus_connect/models/connect_plus_user.dart';
import 'package:erasmus_connect/screens/homepage/bottom_navigation_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class AccommodationPage extends ConsumerStatefulWidget {
  final Function(int) goToPage;
  AccommodationPage({required this.goToPage});
  @override
  AccommodationPageState createState() => AccommodationPageState();
}

class AccommodationPageState extends ConsumerState<AccommodationPage> {
  final List<String> imageUrls = [
    'assets/images/turkey_accommodation.png',
    'assets/images/sweden_accommodation.png',
    'assets/images/italy_accommodation.png',
    'assets/images/germany_accommodation.png',
    'assets/images/netherlands_accommodation.png',
    // Add more image URLs here
  ];

  final List<String> accommodationTitles = [
    "Türkiye'de Konaklama",
    "İsveç'te Konaklama",
    "İtalya'da Konaklama",
    "Almanya'da Konaklama",
    "Hollanda'da Konaklama",
    // Add more trip titles here
  ];

  final List<String> accommodationTexts = [
    "Türkiye'de konaklamak istediğiniz yerleri keşfedin!",
    "İsveç'te konaklamak istediğiniz yerleri keşfedin!",
    "İtalya'da konaklamak istediğiniz yerleri keşfedin!",
    "Almanya'da konaklamak istediğiniz yerleri keşfedin!",
    "Hollanda'da konaklamak istediğiniz yerleri keşfedin!",
    // Add more trip titles here
  ];

  final List<String> accommodationContent1 = [
    "• Öğrenci yurtları: Türkiye'de birçok üniversitenin kampüsünde veya çevresinde öğrenci yurtları bulunmaktadır. Yurtlarda genellikle uygun fiyatlarla konaklama imkanı sağlanmaktadır. Üniversitenizin konaklama birimiyle iletişime geçerek yurt başvurusu yapabilirsiniz.",
    "• Öğrenci konutları: İsveç'te üniversitelere bağlı olarak öğrenci konutları bulunmaktadır. Bu konutlarda genellikle uygun fiyatlarla kalma imkanı sağlanır. Üniversitenizin konaklama birimiyle iletişime geçerek başvuruda bulunabilirsiniz.",
    "• Öğrenci yurtları: İtalya'da birçok üniversitenin kampüsünde veya çevresinde öğrenci yurtları bulunmaktadır. Yurtlarda genellikle uygun fiyatlarla konaklama imkanı sunulur. Üniversitenizin konaklama birimiyle iletişime geçerek yurt başvurusu yapabilirsiniz.",
    "• Studentenwerk: Almanya'da birçok üniversitenin öğrenci konutları Studentenwerk tarafından işletilmektedir. Bu konutlar genellikle uygun fiyatlarla konaklama imkanı sunar. Üniversitenizin konaklama birimiyle iletişime geçerek başvuruda bulunabilirsiniz.",
    "• Facebook grupları: Hollanda'daki üniversitelerde öğrenci toplulukları ve konut grupları bulunmaktadır. Bu gruplara katılarak konut ilanlarını takip edebilir ve ev arkadaşı arayışında bulunabilirsiniz. Üniversitenizin Facebook sayfasını veya öğrenci birliği sayfasını kontrol edebilirsiniz.",
  ];

  final List<String> accommodationContent2 = [
    "\n• Ev paylaşımı: Türkiye'de ev paylaşımı yapmak, hem bütçenizi rahatlatır hem de yerel öğrencilerle daha yakın etkileşim kurmanızı sağlar. Facebook grupları veya öğrenci platformları üzerinden ev arkadaşı arayışında bulunabilirsiniz. Örneğin; Sahibinden",
    "\n• SSSB: Stockholm'de öğrenciler için özel bir konut şirketi olan SSSB, uygun fiyatlarla öğrenci konutları sunmaktadır. SSSB'nin resmi web sitesi üzerinden başvuru yapabilirsiniz. Örneğin; SSSB",
    "\n• Ev paylaşımı: İtalya'da ev paylaşımı yapmak, hem bütçenizi rahatlatır hem de yerel yaşamı daha yakından deneyimlemenizi sağlar. Öğrenci platformları veya ilan siteleri üzerinden ev arkadaşı arayışında bulunabilirsiniz. Örneğin;  Idealista",
    "\n• WG-Gesucht",
    "\n• Kamernet: Öğrenci odası veya daire paylaşımı ilanlarının bulunduğu bir platformdur. Hollanda'nın çeşitli şehirlerindeki konut ilanlarını araştırabilirsiniz. Website:",
  ];

  final List<String> accommodationContent3 = [
    ": Ev paylaşımı için ilanların bulunduğu popüler bir site. 'Kiralık Oda' veya 'Ev Arkadaşı Aranıyor' gibi ilanları arayabilirsiniz.",
    "Stockholm'de öğrenci konutları sunan bir kuruluştur.",
    "İtalya genelinde ev paylaşımı ilanlarını bulabileceğiniz bir platformdur.",
    ": Almanya'da popüler olan bir ev paylaşımı platformudur. Burada 'WG-Zimmer' (ortak ev odası) veya 'Wohnung' (daire) ilanlarını arayabilirsiniz. Hem öğrencilerle hem de yerel halkla birlikte yaşama fırsatı bulabilirsiniz.",
    "",
  ];
  final List<String> accommodationContent4 = [
    "• Kiralık daireler: Türkiye'de birçok şehirde kiralık daire seçenekleri bulunmaktadır. Emlak siteleri veya yerel emlak ofisleri üzerinden bütçenize uygun daireleri araştırabilirsiniz. Örneğin; Zingat",
    "• Ev paylaşımı: İsveç'te ev paylaşımı yapmak, hem maliyetleri düşürür hem de sosyal etkileşimi artırır. Hem İsveçli hem de uluslararası öğrencilerle ev arkadaşı arayışında bulunabilirsiniz. Örneğin; Blocket",
    "• Kiralık daireler: İtalya'da birçok şehirde kiralık daire seçenekleri bulunmaktadır. Emlak siteleri veya yerel emlak ofisleri üzerinden bütçenize uygun daireleri araştırabilirsiniz. Örneğin; Immobiliare",
    "• ImmobilienScout24",
    "• HousingAnywhere: Öğrencilere yönelik konut arama platformudur. Hollanda genelindeki kiralık konutları görebilir ve kiracılarla iletişime geçebilirsiniz. Website:",
  ];
  final List<String> accommodationContent5 = [
    "Kiralık daire ilanlarını bulabileceğiniz bir emlak platformudur.",
    "İsveç genelinde ev paylaşımı ilanlarını bulabileceğiniz bir platformdur ek olarak  Hemnet (https://www.hemnet.se/) İsveç genelinde kiralık daireleri listeleyen bir emlak platformudur.",
    "İtalya genelinde kiralık daireleri listeleyen bir emlak platformudur.",
    ": Almanya genelinde kiralık daire seçenekleri sunan bir emlak platformudur. Burada bütçenize uygun daireleri araştırabilir ve başvuruda bulunabilirsiniz.",
    "",
  ];

  final List<String> accommodationLinksTex1 = [
    " (https://www.sahibinden.com/) ",
    " (https://www.sssb.se/) ",
    " (https://www.idealista.it/) ",
    " (https://www.wg-gesucht.de/): ",
    " (https://kamernet.nl/) ",
  ];

  final List<String> accommodationLinksTex2 = [
    " (https://www.zingat.com/): ",
    " (https://www.blocket.se/) ",
    " (https://www.immobiliare.it/) ",
    " (https://www.immobilienscout24.de/): ",
    " (https://housinganywhere.com/) ",
  ];

  final List<String> accommodationLink1 = [
    "www.sahibinden.com",
    "www.sssb.se",
    "www.idealista.it",
    "www.wg-gesucht.de",
    "kamernet.nl",
  ];

  final List<String> accommodationLink2 = [
    "www.zingat.com",
    "www.blocket.se",
    "www.immobiliare.it",
    "www.immobilienscout24.de",
    "housinganywhere.com",
  ];

  final ScrollController _scrollController = ScrollController();

  int _selectedFlagIndex = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSelectedFlag() {
    if (_selectedFlagIndex < imageUrls.length) {
      final double itemExtent = MediaQuery.of(context).size.width * 0.84 + 6;
      final double scrollToOffset = _selectedFlagIndex * itemExtent;
      _scrollController.animateTo(
        scrollToOffset,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  // Her hangi bir url'i açmak için kullanılabilir.
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    ConnectPlusUser user = ref.watch(userProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 247, 235, 225),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: user.profilePicture != ""
                              ? Image.network(user.profilePicture.toString(),
                              fit: BoxFit.cover)
                              .image
                              : AssetImage("assets/images/Default_pp.png"),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Color.fromARGB(255, 247, 235, 225),
                                  width: 2),
                              color: Color.fromARGB(255, 251, 137,
                                  39), // Replace with desired color
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "WELCOME BACK",
                          style: TextStyle(fontSize: 10),
                        ),
                        Text(
                          "${user.fullName}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  height: 100, // Set the desired height for the images
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: imageUrls.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedFlagIndex = index;
                            });
                            _scrollToSelectedFlag();
                          },
                          child: Stack(
                            children: [
                              Image.asset('assets/images/flags$index.png'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          filled: true,
                          fillColor: Color.fromARGB(255, 250, 229, 210),
                          hintText: 'Ara...',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 237, 164, 126),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color.fromARGB(255, 237, 164, 126),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (value) {},
                        onTap: () {
                          widget.goToPage(23);
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 250, 229,
                            210), // Background color of the button
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          // Add your onTap logic here
                        },
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Image.asset(
                            'assets/images/filter_img.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Color.fromARGB(
                        255, 247, 235, 225), // Background color of the button
                  ),
                  width: MediaQuery.of(context).size.width * 0.94,
                  height: MediaQuery.of(context).size.height *
                      0.46, // Set the desired height for the images
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    itemCount: imageUrls.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 60),
                                child: AlertDialog(
                                  contentPadding: EdgeInsets.all(24),
                                  backgroundColor:
                                      Color.fromARGB(255, 189, 104, 28),
                                  content: SingleChildScrollView(
                                    child: Container(
                                      width: double.maxFinite,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            accommodationTitles[index],
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  accommodationContent1[index],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            accommodationContent2[
                                                                index],
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            accommodationLinksTex1[
                                                                index],
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            decorationColor:
                                                                Colors.white),
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap =
                                                                  () async {
                                                                await _launchUrl(
                                                                    accommodationLink1[
                                                                        index]);
                                                              },
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            accommodationContent3[
                                                                index],
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            accommodationContent4[
                                                                index],
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            accommodationLinksTex2[
                                                                index],
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            decorationColor:
                                                                Colors.white),
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap =
                                                                  () async {
                                                                await _launchUrl(
                                                                    accommodationLink2[
                                                                        index]);
                                                              },
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            accommodationContent5[
                                                                index],
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
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: Image.asset(
                                imageUrls[index],
                                width: MediaQuery.of(context).size.width * 0.84,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              left: 0,
                              bottom: 0,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, left: 24.0),
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 255, 252, 241),
                                          Color.fromARGB(255, 255, 217, 182),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(
                                        'assets/images/eye_img.png',
                                        width: 64,
                                        height: 64,
                                        fit: BoxFit.fill,
                                      ),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              left: 0,
                              bottom: 0,
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        accommodationTitles[index],
                                        style: TextStyle(
                                          shadows: [
                                            Shadow(
                                              blurRadius: 5.0,
                                              color: Colors.black,
                                              offset: Offset(2.0, 2.0),
                                            ),
                                          ],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                      ),
                                      Text(
                                        accommodationTexts[index],
                                        style: TextStyle(
                                          shadows: [
                                            Shadow(
                                              blurRadius: 5.0,
                                              color: Colors.black,
                                              offset: Offset(2.0, 2.0),
                                            ),
                                          ],
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 12,
                                            backgroundImage: NetworkImage(
                                                'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            "F - 47",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
