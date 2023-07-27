import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erasmus_connect/core/app_export.dart';
import 'package:erasmus_connect/screens/homepage/bottom_navigation_bar.dart';
import 'package:erasmus_connect/widgets/custom_button.dart';
import 'package:erasmus_connect/widgets/custom_icon_button.dart';
import 'package:erasmus_connect/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/connect_plus_user.dart';
import '../../../services/auth.dart';
import '../../../services/database.dart';
import '../forgot_password_screen/forgot_password_screen.dart';
import '../register_screen/register_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final isObscureProvider = StateProvider<bool>((ref) => true);

class LoginScreen extends ConsumerWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 255, 229, 204),
                Color.fromARGB(255, 255, 123, 0),
              ],
            ),
          ),
          child: Form(
            key: _formKey,
            child: Container(
              width: double.maxFinite,
              padding: getPadding(left: 12, top: 63, right: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomIconButton(
                      height: 41,
                      width: 41,
                      margin: getMargin(left: 24),
                      alignment: Alignment.centerLeft,
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => BottomNavigation(),
                          ),
                        );
                      },
                      child:
                          CustomImageView(svgPath: ImageConstant.imgArrowleft)),
                  Container(
                      width: getHorizontalSize(289),
                      margin: getMargin(left: 30, top: 23, right: 31),
                      child: Text(AppLocalizations.of(context).hosgeldin,
                          maxLines: null,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtUrbanistRomanBold25)),
                  CustomTextFormField(
                      focusNode: FocusNode(),
                      autofocus: false,
                      controller: emailController,
                      hintText: AppLocalizations.of(context).emailadresinigir,
                      margin: getMargin(left: 28, top: 38, right: 30),
                      variant: TextFormFieldVariant.OutlineIndigo50_1,
                      textInputType: TextInputType.emailAddress),
                  Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      bool isObscure = ref.watch(isObscureProvider);
                      return CustomTextFormField(
                          focusNode: FocusNode(),
                          autofocus: false,
                          controller: passwordController,
                          hintText: AppLocalizations.of(context).sifrenigir,
                          isObscureText: isObscure,
                          margin: getMargin(left: 28, top: 15, right: 28),
                          padding: TextFormFieldPadding.PaddingT19_1,
                          textInputAction: TextInputAction.done,
                          suffix: GestureDetector(
                            onTap: () {
                              ref.watch(isObscureProvider.notifier).state =
                                  !isObscure;
                            },
                            child: Container(
                                margin: getMargin(
                                    left: 30, top: 17, right: 14, bottom: 17),
                                child: CustomImageView(
                                    svgPath:
                                        ImageConstant.imgFluenteye20filled)),
                          ),
                          suffixConstraints:
                              BoxConstraints(maxHeight: getVerticalSize(56)));
                    },
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen()));
                        },
                        child: Padding(
                            padding: getPadding(top: 15, right: 30),
                            child: Text(
                                AppLocalizations.of(context).sifrenimiunuttun,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtUrbanistRomanSemiBold14)),
                      )),
                  CustomButton(
                      onTap: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         BottomNavigation(),
                        //   ),
                        // );
                        LoginWithEmailAndPass(
                            email: emailController.text,
                            password: passwordController.text,
                            ref: ref,
                            context: context);
                      },
                      height: getVerticalSize(56),
                      text: AppLocalizations.of(context).girisyap,
                      margin: getMargin(left: 33, top: 29, right: 28)),
                  Padding(
                      padding: getPadding(left: 8, top: 36),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: getPadding(top: 7, bottom: 8),
                                child: SizedBox(
                                    width: getHorizontalSize(90),
                                    child: Divider(
                                        height: getVerticalSize(1),
                                        thickness: getVerticalSize(1),
                                        color: ColorConstant.indigo50))),
                            Padding(
                                padding: getPadding(left: 6),
                                child: Text(
                                    AppLocalizations.of(context)
                                        .yadasununlagirisyap,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style:
                                        AppStyle.txtUrbanistRomanSemiBold14)),
                            Padding(
                                padding: getPadding(top: 7, bottom: 8),
                                child: SizedBox(
                                    width: getHorizontalSize(102),
                                    child: Divider(
                                        height: getVerticalSize(1),
                                        thickness: getVerticalSize(1),
                                        color: ColorConstant.indigo50,
                                        indent: getHorizontalSize(11))))
                          ])),
                  Padding(
                    padding: getPadding(left: 17, top: 20, right: 19),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 0,
                          margin: EdgeInsets.all(0),
                          color: ColorConstant.whiteA700,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: ColorConstant.indigo50,
                                  width: getHorizontalSize(1)),
                              borderRadius: BorderRadiusStyle.roundedBorder8),
                          child: Container(
                            height: getVerticalSize(55),
                            width: getHorizontalSize(99),
                            padding: getPadding(
                                left: 35, top: 14, right: 35, bottom: 14),
                            decoration: AppDecoration.outlineIndigo50.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder8),
                            child: Stack(
                              children: [
                                CustomImageView(
                                    svgPath: ImageConstant.imgFacebookic,
                                    height: getVerticalSize(25),
                                    width: getHorizontalSize(24),
                                    alignment: Alignment.centerLeft)
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            LoginWithGoogleAccount(ref: ref, context: context);
                          },
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 0,
                            margin: getMargin(left: 7),
                            color: ColorConstant.whiteA700,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: ColorConstant.indigo50,
                                    width: getHorizontalSize(1)),
                                borderRadius: BorderRadiusStyle.roundedBorder8),
                            child: Container(
                              height: getVerticalSize(55),
                              width: getHorizontalSize(99),
                              padding: getPadding(
                                  left: 35, top: 14, right: 35, bottom: 14),
                              decoration: AppDecoration.outlineIndigo50
                                  .copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder8),
                              child: Stack(
                                children: [
                                  CustomImageView(
                                      svgPath: ImageConstant.imgGoogleic,
                                      height: getVerticalSize(25),
                                      width: getHorizontalSize(24),
                                      alignment: Alignment.centerLeft)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 0,
                          margin: getMargin(left: 7),
                          color: ColorConstant.whiteA700,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: ColorConstant.indigo50,
                                  width: getHorizontalSize(1)),
                              borderRadius: BorderRadiusStyle.roundedBorder8),
                          child: Container(
                            height: getVerticalSize(55),
                            width: getHorizontalSize(99),
                            padding: getPadding(
                                left: 35, top: 14, right: 35, bottom: 14),
                            decoration: AppDecoration.outlineIndigo50.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder8),
                            child: Stack(
                              children: [
                                CustomImageView(
                                    svgPath: ImageConstant.imgCibapple,
                                    height: getVerticalSize(25),
                                    width: getHorizontalSize(24),
                                    alignment: Alignment.centerLeft)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: getPadding(top: 86, bottom: 5),
                    child: GestureDetector(
                      onTap: () async {
                        bool isAccountOpened = await Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                        if (isAccountOpened) {
                          Navigator.of(context).pop();
                        }
                      },
                      child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text:
                                      AppLocalizations.of(context).hesabinyokmu,
                                  style: TextStyle(
                                      color: ColorConstant.gray900,
                                      fontSize: getFontSize(15),
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: getHorizontalSize(0.15))),
                              TextSpan(
                                  text:
                                      AppLocalizations.of(context).simdikayitol,
                                  style: TextStyle(
                                      color: ColorConstant.green300,
                                      fontSize: getFontSize(15),
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: getHorizontalSize(0.15)))
                            ],
                          ),
                          textAlign: TextAlign.left),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void LoginWithEmailAndPass(
      {required String email,
      required String password,
      required BuildContext context,
      required WidgetRef ref}) async {
    final bool x = await FirebaseAuthServiceMethods(FirebaseAuth.instance)
        .SignInWithEmail(email: email, password: password, context: context);
    if (x) {
      CreateProviderDatas(ref: ref, context: context);
    }
  }

  void LoginWithGoogleAccount(
      {required WidgetRef ref, required BuildContext context}) async {
    final bool x = await FirebaseAuthServiceMethods(FirebaseAuth.instance)
        .SignInWithGoogle(context, isCreatingAcc: false);
    if (x) {
      CreateProviderDatas(ref: ref, context: context);
    }
  }

  Future<void> CreateProviderDatas(
      {required WidgetRef ref, required BuildContext context}) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final Map<String, dynamic>? userCollection =
        await FirebaseFireStoreMethods(FirebaseFirestore.instance)
            .GetUser(currentUser!.uid);
    ref.read(userProvider.notifier).ChangeUser(ConnectPlusUser(
        profilePicture: userCollection!['profilePicture'],
        uId: currentUser!.uid,
        fullName: userCollection!["fullName"],
        mail: currentUser.email,
        phone: userCollection!["phone"],
        isMailVerified: currentUser.emailVerified,
        nickName: userCollection["nickName"],
        gender: userCollection["gender"],
        country: userCollection["country"],
        city: userCollection["city"],
        type: userCollection["type"],
        school: userCollection["school"],
        erasmusSchool: userCollection["erasmusSchool"],
        aboutMe: userCollection["aboutMe"],
        lessons: userCollection["lessons"],
        skills: userCollection["skills"],
        chatUsers: userCollection["chatUsers"]));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => BottomNavigation(),
      ),
    );
  }
}
