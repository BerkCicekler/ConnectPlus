import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TermOfUsePage extends StatelessWidget {
  final Function(int) goToPage;

  const TermOfUsePage({required this.goToPage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                'Kullanım Şartları',
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
        backgroundColor: Color.fromARGB(255, 255, 248, 242),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hoş geldiniz! Bu uygulamayı kullanmadan önce aşağıdaki kullanım şartlarını dikkatlice okuyun:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Uygulama Kullanımı:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Bu uygulamayı kullanarak, aşağıdaki şartları ve politikaları kabul etmiş olursunuz. Uygulamayı yasalara uygun, etik kurallara riayet ederek ve diğer kullanıcıların haklarına saygı göstererek kullanmalısınız.',
                ),
                SizedBox(height: 8),
                Text(
                  'Kullanıcı Sorumluluğu: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Uygulamayı kullanırken, kişisel bilgilerinizi doğru ve güncel tutmalısınız. Kendi kullanıcı adınızı ve şifrenizi güvenli bir şekilde saklamalısınız. Uygulamada paylaştığınız içeriklerin sorumluluğu size aittir.',
                ),
                SizedBox(height: 8),
                Text(
                  'Fikri Mülkiyet Hakları:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Bu uygulama ve içeriği üzerindeki tüm fikri mülkiyet hakları bize aittir veya lisanslıdır. İzin almadan içeriği kopyalamak, dağıtmak veya ticari amaçlarla kullanmak yasaktır.',
                ),
                SizedBox(height: 8),
                Text(
                  'Hizmet Değişiklikleri:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Uygulamayı geliştirme ve iyileştirme amacıyla zaman zaman hizmetleri ve özellikleri değiştirebiliriz. Bu değişiklikleri önceden bildirmek zorunda değiliz.',
                ),
                SizedBox(height: 8),
                Text(
                  'Kullanıcı Hakları:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Uygulama kullanıcılarının gizlilik haklarına saygı gösteririz. Kişisel bilgilerinizi korumak ve paylaşmak için gizlilik politikamıza uygun olarak hareket ederiz.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
