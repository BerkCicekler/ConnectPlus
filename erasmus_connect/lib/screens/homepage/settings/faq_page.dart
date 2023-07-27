import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  final Function(int) goToPage;

  const FAQPage({required this.goToPage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 248, 242),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(128, 255, 144, 34),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  goToPage(3);
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
              Text(
                'Sıkça Sorulan Sorular',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                CupertinoIcons.chevron_back,
                color: Colors.transparent,
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            FAQItem(
              question: '1. Connect+ uygulaması nedir?',
              answer:
                  'Connect+, Erasmus öğrencilerini bir araya getiren yenilikçi bir mobil uygulamadır. Öğrenciler, uygulama üzerinden birbirleriyle iletişim kurabilir, deneyimlerini paylaşabilir, mentorluk ilişkileri geliştirebilir ve Erasmus deneyimlerini en iyi şekilde yaşayabilmek için rehberlik alabilirler.',
            ),
            FAQItem(
              question: '2. Connect+ uygulamasını nasıl kullanabilirim?',
              answer:
                  'Connect+, Erasmus öğrencilerini bir araya getiren yenilikçi bir mobil uygulamadır. Öğrenciler, uygulama üzerinden birbirleriyle iletişim kurabilir, deneyimlerini paylaşabilir, mentorluk ilişkileri geliştirebilir ve Erasmus deneyimlerini en iyi şekilde yaşayabilmek için rehberlik alabilirler.',
            ),
            FAQItem(
              question: '3. Connect+ uygulamasında neler yapabilirim?',
              answer:
                  'Connect+, Erasmus öğrencilerini bir araya getiren yenilikçi bir mobil uygulamadır. Öğrenciler, uygulama üzerinden birbirleriyle iletişim kurabilir, deneyimlerini paylaşabilir, mentorluk ilişkileri geliştirebilir ve Erasmus deneyimlerini en iyi şekilde yaşayabilmek için rehberlik alabilirler.',
            ),
            FAQItem(
              question: '4. Connect+ uygulaması ücretsiz midir?',
              answer:
                  'Connect+, Erasmus öğrencilerini bir araya getiren yenilikçi bir mobil uygulamadır. Öğrenciler, uygulama üzerinden birbirleriyle iletişim kurabilir, deneyimlerini paylaşabilir, mentorluk ilişkileri geliştirebilir ve Erasmus deneyimlerini en iyi şekilde yaşayabilmek için rehberlik alabilirler.',
            ),
            FAQItem(
              question:
                  '5. Connect+ uygulamasında nasıl mentorluk programına katılabilirim?',
              answer:
                  'Connect+, Erasmus öğrencilerini bir araya getiren yenilikçi bir mobil uygulamadır. Öğrenciler, uygulama üzerinden birbirleriyle iletişim kurabilir, deneyimlerini paylaşabilir, mentorluk ilişkileri geliştirebilir ve Erasmus deneyimlerini en iyi şekilde yaşayabilmek için rehberlik alabilirler.',
            ),
          ],
        ),
      ),
    );
  }
}

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const FAQItem({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: Colors.black, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            title: Text(
              widget.question,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(
              expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            ),
          ),
          if (expanded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(widget.answer),
            ),
        ],
      ),
    );
  }
}
