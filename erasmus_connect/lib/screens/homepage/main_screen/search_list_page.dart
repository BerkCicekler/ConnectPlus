import 'package:erasmus_connect/screens/homepage/main_screen/accommodation_page.dart';
import 'package:erasmus_connect/screens/homepage/main_screen/schools_page.dart';
import 'package:erasmus_connect/screens/homepage/main_screen/travel_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchResultsPage extends StatefulWidget {
  final Function(int) goToPage;

  const SearchResultsPage({required this.goToPage, Key? key}) : super(key: key);

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  TextEditingController _searchController = TextEditingController();
  List<String> _travelCountries = [
    "Türkiye'de Gezilecek Rotalar",
    "İsveç'te Gezilecek Rotalar",
    "İtalya'da Gezilecek Rotalar",
    "Kanada'da Gezilecek Rotalar",
    "Hollanda'da Gezilecek Rotalar",
  ];
  List<String> _accommodationCountries = [
    "Türkiye'de Konaklama",
    "İsveç'te Konaklama",
    "İtalya'da Konaklama",
    "Almanya'da Konaklama",
    "Hollanda'da Konaklama",
  ];
  List<String> _schools = [
    "İstanbul Teknik Üniversitesi Bilgilendirme",
    "Orta Doğu Teknik Üniversitesi Bilgilendirme",
    "Boğaziçi Üniversitesi Bilgilendirme",
    "Boras Üniversitesi Bilgilendirme",
    "Uppsala Üniversitesi Bilgilendirme",
    "Stockholm Üniversitesi Bilgilendirme",
    "Bologna Üniversitesi Bilgilendirme",
    "Milano Üniversitesi Bilgilendirme",
    "Rome La Sapienza Üniversitesi Bilgilendirme",
    "Münih Teknik Üniversitesi Bilgilendirme",
    "Berlin Teknik Üniversitesi Bilgilendirme",
    "Stuttgart Üniversitesi Bilgilendirme",
    "Delft Üniversitesi Bilgilendirme",
    "Inholland Üniversitesi Bilgilendirme",
    "Hague Üniversitesi Bilgilendirme",
  ];

  List<String> _visa = [
    "Türkiye'de Vize Süreci",
    "İsveç'te Vize Süreci",
    "İtalya'da Vize Süreci",
    "Kanada'da Vize Süreci",
    "Hollanda'da Vize Süreci",
  ];

  List<String> _residency = [
    "Türkiye'de Oturum İzni",
    "İsveç'te Oturum İzni",
    "İtalya'da Oturum İzni",
    "Kanada'da Oturum İzni",
    "Hollanda'da Oturum İzni",
  ];

  List<String> _healthInsurance = [
    "Türkiye'de Sağlık Sigortası",
    "İsveç'te Sağlık Sigortası",
    "İtalya'da Sağlık Sigortası",
    "Kanada'da Sağlık Sigortası",
    "Hollanda'da Sağlık Sigortası",
  ];

  List<String> _educationCommunities = [
    "Kaliteli Eğitim Toplulukları",
  ];

  List<String> _schoolsCommunities = [
    "İstanbul Teknik Üniversitesi Topluluğu",
    "Orta Doğu Teknik Üniversitesi Topluluğu",
    "Boğaziçi Üniversitesi Topluluğu",
    "Boras Üniversitesi Topluluğu",
    "Uppsala Üniversitesi Topluluğu",
    "Stockholm Üniversitesi Topluluğu",
    "Bologna Üniversitesi Topluluğu",
    "Milano Üniversitesi Topluluğu",
    "Rome La Sapienza Üniversitesi Topluluğu",
    "Münih Teknik Üniversitesi Topluluğu",
    "Berlin Teknik Üniversitesi Topluluğu",
    "Stuttgart Üniversitesi Topluluğu",
    "Delft Üniversitesi Topluluğu",
    "Inholland Üniversitesi Topluluğu",
    "Hague Üniversitesi Topluluğu",
  ];

  List<String> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchQueryChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchQueryChanged() {
    _performSearch(_searchController.text);
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
            Text(
              AppLocalizations.of(context).aramayap,
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
      ),
      backgroundColor: Color.fromARGB(255, 255, 248, 242),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        filled: true,
                        fillColor: Color.fromARGB(255, 250, 229, 210),
                        hintText: AppLocalizations.of(context).ara,
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
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromARGB(
                          255, 250, 229, 210), // Background color of the button
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        widget.goToPage(22);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Image.asset(
                          'assets/images/filter_img.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(176, 224, 137, 50),
                      border: Border.all(
                        color: Color.fromARGB(255, 217, 114, 11),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(22),
                      ),
                    ),
                    child: ListTile(
                      title: Text(_searchResults[index]),
                      onTap: () {
                        _navigateToPage(_searchResults[index]);
                      },
                      trailing: Icon(Icons.arrow_circle_right_outlined),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _performSearch(String query) {
    setState(() {
      _searchResults.clear();
      if (query.isNotEmpty) {
        for (String country in _travelCountries) {
          if (country.toLowerCase().contains(query.toLowerCase())) {
            _searchResults.add(country);
          }
        }
        for (String country in _accommodationCountries) {
          if (country.toLowerCase().contains(query.toLowerCase())) {
            _searchResults.add(country);
          }
        }
        for (String school in _schools) {
          if (school.toLowerCase().contains(query.toLowerCase())) {
            _searchResults.add(school);
          }
        }
        for (String visa in _visa) {
          if (visa.toLowerCase().contains(query.toLowerCase())) {
            _searchResults.add(visa);
          }
        }
        for (String residency in _residency) {
          if (residency.toLowerCase().contains(query.toLowerCase())) {
            _searchResults.add(residency);
          }
        }
        for (String healthInsurance in _healthInsurance) {
          if (healthInsurance.toLowerCase().contains(query.toLowerCase())) {
            _searchResults.add(healthInsurance);
          }
        }
        for (String educationCommunity in _educationCommunities) {
          if (educationCommunity.toLowerCase().contains(query.toLowerCase())) {
            _searchResults.add(educationCommunity);
          }
        }
        for (String schoolCommunity in _schoolsCommunities) {
          if (schoolCommunity.toLowerCase().contains(query.toLowerCase())) {
            _searchResults.add(schoolCommunity);
          }
        }
      }
    });
  }

  void _navigateToPage(String selectedItem) {
    if (_travelCountries.contains(selectedItem)) {
      widget.goToPage(5);
    } else if (_accommodationCountries.contains(selectedItem)) {
      widget.goToPage(6);
    } else if (_schools.contains(selectedItem)) {
      widget.goToPage(7);
    } else if (_visa.contains(selectedItem)) {
      widget.goToPage(8);
    } else if (_residency.contains(selectedItem)) {
      widget.goToPage(9);
    } else if (_healthInsurance.contains(selectedItem)) {
      widget.goToPage(11);
    } else if (_educationCommunities.contains(selectedItem)) {
      widget.goToPage(12);
    } else if (_schoolsCommunities.contains(selectedItem)) {
      widget.goToPage(17);
    }
  }
}
