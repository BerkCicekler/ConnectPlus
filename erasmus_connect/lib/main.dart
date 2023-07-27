import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:erasmus_connect/firebase_options.dart';
import 'package:erasmus_connect/l10n/l10n.dart';
import 'package:erasmus_connect/screens/onboarding_screen/animation_screens.dart';
import 'package:erasmus_connect/screens/registeration_login/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isOnboardingShown = prefs.getBool('isOnboardingShown') ?? true;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Color.fromARGB(255, 241, 151, 49),
        ledColor: Colors.white,
      ),
    ],
    debug: true,
  );

  // final firebaseApi = FirebaseApi();
  // firebaseApi.initNotifications();
  //runApp(MyApp());

  //--------------------------ÖNEMLİ--------------------------//
  // Bu kısım arayüz tarafını tamamladıktan sonra aktif edilecektir.
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(isIntroduction: isOnboardingShown),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.isIntroduction});
  final bool isIntroduction;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale currentLocale = Locale('tr');

  void changeLocale() {
    setState(() {
      currentLocale =
          currentLocale.languageCode == 'tr' ? Locale('en') : Locale('tr');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MainMaterialApp(widget: widget),
    );
  }
}

class MainMaterialApp extends ConsumerWidget {
  const MainMaterialApp({
    super.key,
    required this.widget,
  });

  final MyApp widget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var locale = ref.watch(selectedLocaleProvider);
    return MaterialApp(
      title: 'Connect Plus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      supportedLocales: L10n.all,
      locale: locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      //home: BottomNavigation(),
      //--------------------------ÖNEMLİ--------------------------//
      // Bu kısım arayüz tarafını tamamladıktan sonra aktif edilecektir.
      home: widget.isIntroduction == true
          ? IntroductionAnimationScreen()
          : LoginScreen(),
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: Text(
      //       "Connect Plus",
      //       style: TextStyle(color: Colors.white),
      //     ),
      //     backgroundColor: Colors.deepPurpleAccent,
      //   ),
      //   body: Consumer(
      //     builder: (context, ref, child) {
      //       final pageIndex = ref.watch(pageIndexProvider);
      //       return allPages[pageIndex];
      //     },
      //   ),
      //   bottomNavigationBar: my_navigator_bar(),
      // ),
    );
  }
}
