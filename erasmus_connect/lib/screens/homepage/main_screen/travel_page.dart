import 'package:card_swiper/card_swiper.dart';
import 'package:erasmus_connect/models/connect_plus_user.dart';
import 'package:erasmus_connect/screens/homepage/bottom_navigation_bar.dart';
import 'package:erasmus_connect/screens/homepage/chatbot/chatbot_page.dart';
import 'package:erasmus_connect/screens/homepage/profile_page.dart';
import 'package:erasmus_connect/screens/homepage/chats_page.dart';
import 'package:erasmus_connect/screens/homepage/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class TravelPage extends ConsumerStatefulWidget {
  final Function(int) goToPage;
  TravelPage({required this.goToPage});
  @override
  TravelPageState createState() => TravelPageState();
}

class TravelPageState extends ConsumerState<TravelPage> {
  final List<String> imageUrls = [
    'assets/images/turkey_travel.png',
    'assets/images/sweden_travel.png',
    'assets/images/italy_travel.png',
    'assets/images/germany_travel.png',
    'assets/images/netherlands_travel.png',
    // Add more image URLs here
  ];

  final List<String> travelTitles = [
    "Türkiye'de Gezilecek Rotalar",
    "İsveç'te Gezilecek Rotalar",
    "İtalya'da Gezilecek Rotalar",
    "Kanada'da Gezilecek Rotalar",
    "Hollanda'da Gezilecek Rotalar",
    // Add more trip titles here
  ];

  final List<String> travelTexts = [
    "Türkiye'de gezmek istediğiniz yerleri keşfedin!",
    "İsveç'te gezmek istediğiniz yerleri keşfedin!",
    "İtalya'da gezmek istediğiniz yerleri keşfedin!",
    "Kanada'da gezmek istediğiniz yerleri keşfedin!",
    "Hollanda'da gezmek istediğiniz yerleri keşfedin!",
    // Add more trip titles here
  ];

  final List<String> travelContent1 = [
    "• İstanbul: Türkiye gezinin başlangıç noktası olarak İstanbul'u tercih edin. Tarihi Yarımada, Ayasofya, Topkapı Sarayı ve Kapalıçarşı gibi önemli yerleri ziyaret edin.",
    "• Stockholm: İsveç'in başkenti olan Stockholm, tarihi Gamla Stan, Kraliyet Sarayı, modern sanat müzeleri ve canlı bir su kenarı yaşamıyla büyüleyici bir şehirdir.",
    "• Roma: Antik Roma İmparatorluğu'nun merkezi olan Roma, Colosseum, Forum Romanum ve Vatikan gibi tarihi ve dini yapılarıyla ünlüdür.",
    "• Berlin: Başkent Berlin, tarihi ve kültürel açıdan zengin bir şehirdir. Berlin Duvarı, Brandenburg Kapısı, Reichstag Binası ve Müzeler Adası gibi önemli noktaları ziyaret edebilirsiniz.",
    "• Londra: İngiltere'nin başkenti olan Londra, Big Ben, Buckingham Sarayı, Tate Modern ve British Museum gibi ikonik yapılarıyla kültür, sanat ve tarih dolu bir şehirdir.",
  ];
  final List<String> travelContent2 = [
    "• Kapadokya: Peri bacalarıyla ünlü Kapadokya, doğal güzellikleri, yeraltı şehirleri ve tarihi kiliseleriyle mistik bir atmosfere sahip benzersiz bir destinasyon dur.",
    "• Gotland: Baltık Denizi'nde yer alan Gotland, Orta Çağ'dan kalma Visby kenti, Gotland Müzesi ve güzel plajlarıyla tarihi ve doğal güzellikleri birleştirir.",
    "• Floransa: Rönesans döneminin doğduğu yer olan Floransa, Uffizi Galerisi, Duomo Katedrali ve Ponte Vecchio gibi sanatsal ve tarihi hazineler sunar.",
    "• Münih: Bavyera bölgesinin başkenti olan Münih, tarihi ve modern yapıları bir arada barındıran bir şehirdir. Marienplatz Meydanı, Frauenkirche, Nymphenburg Sarayı ve Oktoberfest gibi yerleri görmenizi öneririz.",
    "• Edinburgh: İskoçya'nın başkenti olan Edinburgh, Edinburgh Kalesi, Royal Mile ve Holyroodhouse Sarayı gibi tarihi yapıları ve festival atmosferiyle büyüleyici bir destinasyondur.",
  ];
  final List<String> travelContent3 = [
    "• Efes: Antik Roma dönemine ait kalıntılarıyla ünlü Efes, Artemis Tapınağı, Büyük Tiyatro ve Celsus Kütüphanesi gibi yapılarıyla tarihe yolculuk yapmanızı sağlar.",
    "• Göteborg: İsveç'in ikinci büyük şehri olan Göteborg, Liseberg Eğlence Parkı, Uluslararası Sanat Müzesi ve Haga semtiyle dinamik bir kültür sahnesine sahiptir.",
    "• Venedik: Kanalları, gondolları ve San Marco Meydanı ile ünlü Venedik, tarihi sarayları, Büyük Kanal ve San Marco Bazilikası ile romantik bir atmosfer sunar.",
    "• Köln: Ren Nehri üzerinde bulunan Köln, Gotik tarzda inşa edilmiş ünlü Kölner Dom Katedrali'ne ev sahipliği yapar. Ayrıca Romalılardan kalma antik kalıntılar ve renkli şehir merkeziyle de dikkat çeker.",
    "• Bath: Roma döneminden kalma termal banyolarıyla ünlü Bath, Georgian mimarisine sahip Pulteney Köprüsü ve Bath Abbey gibi cazibe merkezleriyle tarih ve zarafet sunar.",
  ];
  final List<String> travelContent4 = [
    "• Antalya: Akdeniz'in incisi Antalya, güzel plajları, tarihi kalıntıları ve lüks tatil köyleriyle tatilciler için popüler bir destinasyon dur.",
    "• Kiruna: Kuzey İsveç'te yer alan Kiruna, Kuzey Işıkları, buz otel ve Jukkasjärvi köyü gibi eşsiz deneyimler sunan bir kış turizmi merkezidir.",
    "• Napoli: İtalya'nın güneyinde yer alan Napoli, muhteşem Amalfi Sahili'ne yakınlığı, tarihi meydanları, sokak pizzacıları ve arkeolojik kalıntılarıyla ünlüdür.",
    "• Neuschwanstein Şatosu: Almanya'nın en ünlü şatolarından biri olan Neuschwanstein, Münih'e yakın bir konumda bulunur. Masalsı görüntüsüyle dikkat çeken bu şatoyu ziyaret edebilirsiniz.",
    "• Oxford: Dünyaca ünlü Oxford Üniversitesi'ne ev sahipliği yapan Oxford, tarihi kolejleri, Bodleian Kütüphanesi ve güzel bot turlarıyla akademik ve kültürel bir merkezdir.",
  ];
  final List<String> travelContent5 = [
    "• Trabzon: Karadeniz'in muhteşem doğasına sahip Trabzon, Sümela Manastırı, Atatürk Köşkü ve Uzungöl gibi turistik yerleriyle doğa ve kültürü bir araya getirir.",
    "• Malmö: Öresund Köprüsü ile Danimarka'ya bağlanan Malmö, Modern Sanat Müzesi, Lilla Torg meydanı ve Turning Torso gökdeleniyle kültür ve mimarinin bir araya geldiği bir şehirdir.",
    "• Milano: Moda ve tasarımın merkezi olan Milano, ünlü Duomo Katedrali, La Scala Opera Binası ve dünya markalarının mağazalarıyla göz kamaştırır.",
    "",
    "• Cambridge: Cambridge Üniversitesi'nin bulunduğu Cambridge, Punting nehri gezintileri, King's College Şapeli ve üniversite binalarıyla tarihi ve huzurlu bir şehirdir.",
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
                                            travelTitles[index],
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
                                                  travelContent1[index],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  travelContent2[index],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  travelContent3[index],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  travelContent4[index],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  travelContent5[index],
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
                                        travelTitles[index],
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
                                        travelTexts[index],
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
