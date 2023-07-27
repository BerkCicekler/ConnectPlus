import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  final Function(int) goToPage;

  const PrivacyPolicyPage({required this.goToPage, Key? key}) : super(key: key);

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
                'Gizlilik Politikası',
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
                  'Gizliliğiniz bizim için önemlidir. Bu uygulamayı kullanırken kişisel bilgilerinizin nasıl kullanıldığı ve korunduğu hakkında aşağıdaki bilgileri dikkatlice okuyun:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Toplanan Bilgiler:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Uygulama kullanımınız sırasında adınız, e-posta adresiniz ve diğer kişisel bilgileriniz gibi belirli bilgileri toplayabilir. Bu bilgileri kullanıcı kimliğinizi belirlemek, size hizmet sunmak ve uygulamayı iyileştirmek amacıyla kullanabiliriz.',
                ),
                SizedBox(height: 8),
                Text(
                  'Bilgi Paylaşımı:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Kişisel bilgilerinizi, yasal yükümlülükler veya kullanım şartlarımız gereği istendiğinde üçüncü taraflarla paylaşabiliriz. Bunun dışında, bilgilerinizi izniniz olmadan başkalarıyla paylaşmayız.',
                ),
                SizedBox(height: 8),
                Text(
                  'Güvenlik:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Kişisel bilgilerinizi korumak için uygun güvenlik önlemlerini alırız. Ancak, herhangi bir internet tabanlı platformda %100 güvenlik sağlanamayacağını unutmayın.',
                ),
                SizedBox(height: 8),
                Text(
                  'Çerezler:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Bu uygulama, çerezler gibi izleme teknolojilerini kullanabilir. Bu teknolojiler, kullanıcı deneyimini iyileştirmek ve analiz yapmak amacıyla kullanılabilir.',
                ),
                SizedBox(height: 8),
                Text(
                  'Üçüncü Taraf Bağlantıları:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Uygulama içindeki bağlantılar, üçüncü taraf web sitelerine yönlendirebilir. Bu web sitelerinin gizlilik politikaları hakkında bilgi sahibi olmanız önemlidir.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
