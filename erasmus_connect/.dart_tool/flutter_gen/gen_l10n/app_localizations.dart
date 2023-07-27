import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr')
  ];

  /// No description provided for @merhaba.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get merhaba;

  /// No description provided for @dil.
  ///
  /// In en, this message translates to:
  /// **'language'**
  String get dil;

  /// No description provided for @okullar.
  ///
  /// In en, this message translates to:
  /// **'Schools'**
  String get okullar;

  /// No description provided for @konaklamatavsiyeleri.
  ///
  /// In en, this message translates to:
  /// **'Accommodation Advice'**
  String get konaklamatavsiyeleri;

  /// No description provided for @gezilecekrotalar.
  ///
  /// In en, this message translates to:
  /// **'Places to Visit'**
  String get gezilecekrotalar;

  /// No description provided for @mentorluk.
  ///
  /// In en, this message translates to:
  /// **'Mentorship'**
  String get mentorluk;

  /// No description provided for @ayniokuldaninsanlar.
  ///
  /// In en, this message translates to:
  /// **'Connecting with People\nfrom the Same School'**
  String get ayniokuldaninsanlar;

  /// No description provided for @onerilenler.
  ///
  /// In en, this message translates to:
  /// **'Recommendations'**
  String get onerilenler;

  /// No description provided for @basvururehberi.
  ///
  /// In en, this message translates to:
  /// **'Application Guide'**
  String get basvururehberi;

  /// No description provided for @ara.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get ara;

  /// No description provided for @vizesurecleri.
  ///
  /// In en, this message translates to:
  /// **'Visa Procedures'**
  String get vizesurecleri;

  /// No description provided for @oturumizni.
  ///
  /// In en, this message translates to:
  /// **'Residence Permit'**
  String get oturumizni;

  /// No description provided for @sagliksigortasi.
  ///
  /// In en, this message translates to:
  /// **'Health Insurance'**
  String get sagliksigortasi;

  /// No description provided for @kaliteliegitim.
  ///
  /// In en, this message translates to:
  /// **'Quality Education Community'**
  String get kaliteliegitim;

  /// No description provided for @hesap.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get hesap;

  /// No description provided for @dilsecenegi.
  ///
  /// In en, this message translates to:
  /// **'Language Option'**
  String get dilsecenegi;

  /// No description provided for @tema.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get tema;

  /// No description provided for @bildirimler.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get bildirimler;

  /// No description provided for @sss.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get sss;

  /// No description provided for @kullanimsartlari.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get kullanimsartlari;

  /// No description provided for @gizlilikpolitikasi.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get gizlilikpolitikasi;

  /// No description provided for @cikisyap.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get cikisyap;

  /// No description provided for @girisyap.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get girisyap;

  /// No description provided for @banabirseysor.
  ///
  /// In en, this message translates to:
  /// **'Ask me anything...'**
  String get banabirseysor;

  /// No description provided for @mesajlar.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get mesajlar;

  /// No description provided for @seninlokasyonun.
  ///
  /// In en, this message translates to:
  /// **'Your Location'**
  String get seninlokasyonun;

  /// No description provided for @trendler.
  ///
  /// In en, this message translates to:
  /// **'Trends'**
  String get trendler;

  /// No description provided for @favorilerim.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorilerim;

  /// No description provided for @gonderiolustur.
  ///
  /// In en, this message translates to:
  /// **'Create Post'**
  String get gonderiolustur;

  /// No description provided for @baslik.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get baslik;

  /// No description provided for @tarih.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get tarih;

  /// No description provided for @konum.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get konum;

  /// No description provided for @saat.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get saat;

  /// No description provided for @gorsel.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get gorsel;

  /// No description provided for @olustur.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get olustur;

  /// No description provided for @etkinliklerigoruntule.
  ///
  /// In en, this message translates to:
  /// **'View Events'**
  String get etkinliklerigoruntule;

  /// No description provided for @topluluklar.
  ///
  /// In en, this message translates to:
  /// **'Communities'**
  String get topluluklar;

  /// No description provided for @katil.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get katil;

  /// No description provided for @katildi.
  ///
  /// In en, this message translates to:
  /// **'Joined'**
  String get katildi;

  /// No description provided for @uye.
  ///
  /// In en, this message translates to:
  /// **'Member'**
  String get uye;

  /// No description provided for @topluluktanayrilin.
  ///
  /// In en, this message translates to:
  /// **'Leave Community'**
  String get topluluktanayrilin;

  /// No description provided for @simdi.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get simdi;

  /// No description provided for @gunonce.
  ///
  /// In en, this message translates to:
  /// **'day ago'**
  String get gunonce;

  /// No description provided for @saatonce.
  ///
  /// In en, this message translates to:
  /// **'hour ago'**
  String get saatonce;

  /// No description provided for @dakikaonce.
  ///
  /// In en, this message translates to:
  /// **'minute ago'**
  String get dakikaonce;

  /// No description provided for @icerik.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get icerik;

  /// No description provided for @aramayap.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get aramayap;

  /// No description provided for @mentorlar.
  ///
  /// In en, this message translates to:
  /// **'Mentors'**
  String get mentorlar;

  /// No description provided for @hakkimda.
  ///
  /// In en, this message translates to:
  /// **'About Me'**
  String get hakkimda;

  /// No description provided for @yetkinlikler.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get yetkinlikler;

  /// No description provided for @alinandersler.
  ///
  /// In en, this message translates to:
  /// **'Taken Courses'**
  String get alinandersler;

  /// No description provided for @bagisyapilacak.
  ///
  /// In en, this message translates to:
  /// **'Charity Organization'**
  String get bagisyapilacak;

  /// No description provided for @okul.
  ///
  /// In en, this message translates to:
  /// **'School:'**
  String get okul;

  /// No description provided for @erasmusokulu.
  ///
  /// In en, this message translates to:
  /// **'Erasmus School:'**
  String get erasmusokulu;

  /// No description provided for @telefonno.
  ///
  /// In en, this message translates to:
  /// **'Phone Number:'**
  String get telefonno;

  /// No description provided for @profiliniduzenle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profiliniduzenle;

  /// No description provided for @okuduguokul.
  ///
  /// In en, this message translates to:
  /// **'School Attended'**
  String get okuduguokul;

  /// No description provided for @ulke.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get ulke;

  /// No description provided for @sehir.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get sehir;

  /// No description provided for @kaydet.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get kaydet;

  /// No description provided for @hosgeldin.
  ///
  /// In en, this message translates to:
  /// **'Welcome! We are glad to see you again!'**
  String get hosgeldin;

  /// No description provided for @emailadresinigir.
  ///
  /// In en, this message translates to:
  /// **'Enter email address'**
  String get emailadresinigir;

  /// No description provided for @sifrenigir.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get sifrenigir;

  /// No description provided for @sifrenimiunuttun.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get sifrenimiunuttun;

  /// No description provided for @yadasununlagirisyap.
  ///
  /// In en, this message translates to:
  /// **'or sign in with'**
  String get yadasununlagirisyap;

  /// No description provided for @hesabinyokmu.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get hesabinyokmu;

  /// No description provided for @simdikayitol.
  ///
  /// In en, this message translates to:
  /// **'Register Now'**
  String get simdikayitol;

  /// No description provided for @merhababaslamakicin.
  ///
  /// In en, this message translates to:
  /// **'Hello! Sign up to get started'**
  String get merhababaslamakicin;

  /// No description provided for @kullaniciadi.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get kullaniciadi;

  /// No description provided for @sifre.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get sifre;

  /// No description provided for @sifrenidogrula.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get sifrenidogrula;

  /// No description provided for @kayitol.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get kayitol;

  /// No description provided for @yadasununlakayitol.
  ///
  /// In en, this message translates to:
  /// **'or sign up with'**
  String get yadasununlakayitol;

  /// No description provided for @zatenhesabinvarmi.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get zatenhesabinvarmi;

  /// No description provided for @simdigirisyap.
  ///
  /// In en, this message translates to:
  /// **'Sign in Now'**
  String get simdigirisyap;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'tr': return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
