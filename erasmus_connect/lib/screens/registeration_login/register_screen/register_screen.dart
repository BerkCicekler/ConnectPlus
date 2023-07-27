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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore_for_file: must_be_immutable
class RegisterScreen extends ConsumerWidget {
  RegisterScreen({Key? key}) : super(key: key);

  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmpasswordController = TextEditingController();

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
              padding: getPadding(left: 22, right: 22),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconButton(
                      height: 41,
                      width: 41,
                      margin: getMargin(left: 2),
                      alignment: Alignment.centerLeft,
                      onTap: () {
                        onTapBtnArrowleft(context);
                      },
                      child:
                          CustomImageView(svgPath: ImageConstant.imgArrowleft)),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          width: getHorizontalSize(265),
                          margin: getMargin(left: 18, top: 14, right: 47),
                          child: Text(
                              AppLocalizations.of(context).merhababaslamakicin,
                              maxLines: null,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtUrbanistRomanBold25))),
                  CustomTextFormField(
                      focusNode: FocusNode(),
                      autofocus: true,
                      controller: usernameController,
                      hintText: AppLocalizations.of(context).kullaniciadi,
                      margin: getMargin(left: 18, top: 39, right: 23),
                      variant: TextFormFieldVariant.OutlineIndigo50_1),
                  CustomTextFormField(
                      focusNode: FocusNode(),
                      autofocus: true,
                      controller: emailController,
                      hintText: AppLocalizations.of(context).emailadresinigir,
                      margin: getMargin(left: 18, top: 12, right: 23),
                      variant: TextFormFieldVariant.OutlineIndigo50_1,
                      textInputType: TextInputType.emailAddress),
                  CustomTextFormField(
                      focusNode: FocusNode(),
                      autofocus: true,
                      controller: passwordController,
                      hintText: AppLocalizations.of(context).sifre,
                      margin: getMargin(left: 18, top: 12, right: 23)),
                  CustomTextFormField(
                      focusNode: FocusNode(),
                      autofocus: true,
                      controller: confirmpasswordController,
                      hintText: AppLocalizations.of(context).sifrenidogrula,
                      margin: getMargin(left: 18, top: 12, right: 23),
                      textInputAction: TextInputAction.done),
                  CustomButton(
                      onTap: () {
                        if (passwordController.text ==
                                confirmpasswordController.text &&
                            usernameController.text.isNotEmpty) {
                          CreateAccountWithMail(
                              mail: emailController.text,
                              password: passwordController.text,
                              fullName: usernameController.text,
                              ref: ref,
                              context: context);
                        }
                      },
                      height: getVerticalSize(56),
                      text: AppLocalizations.of(context).kayitol,
                      margin: getMargin(left: 18, top: 30, right: 23)),
                  Padding(
                    padding: getPadding(top: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: getPadding(top: 8, bottom: 8),
                            child: SizedBox(
                                width: getHorizontalSize(87),
                                child: Divider(
                                    height: getVerticalSize(1),
                                    thickness: getVerticalSize(1),
                                    color: ColorConstant.indigo50))),
                        Text(AppLocalizations.of(context).yadasununlakayitol,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtUrbanistRomanSemiBold14),
                        Padding(
                          padding: getPadding(top: 8, bottom: 8),
                          child: SizedBox(
                            width: getHorizontalSize(88),
                            child: Divider(
                              height: getVerticalSize(1),
                              thickness: getVerticalSize(1),
                              color: ColorConstant.indigo50,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: getPadding(left: 23, top: 13, right: 23),
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
                            height: getVerticalSize(56),
                            width: getHorizontalSize(90),
                            padding: getPadding(
                                left: 31, top: 15, right: 31, bottom: 15),
                            decoration: AppDecoration.outlineIndigo50.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder8),
                            child: Stack(
                              children: [
                                CustomImageView(
                                    svgPath: ImageConstant.imgFacebookic,
                                    height: getVerticalSize(26),
                                    width: getHorizontalSize(22),
                                    alignment: Alignment.centerLeft)
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            CreateAccountWithGoogleAccount(
                                fullName: usernameController.text,
                                ref: ref,
                                context: context);
                          },
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 0,
                            margin: getMargin(left: 6),
                            color: ColorConstant.whiteA700,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: ColorConstant.indigo50,
                                    width: getHorizontalSize(1)),
                                borderRadius: BorderRadiusStyle.roundedBorder8),
                            child: Container(
                              height: getVerticalSize(56),
                              width: getHorizontalSize(90),
                              padding: getPadding(
                                  left: 31, top: 15, right: 31, bottom: 15),
                              decoration: AppDecoration.outlineIndigo50
                                  .copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder8),
                              child: Stack(
                                children: [
                                  CustomImageView(
                                      svgPath: ImageConstant.imgGoogleic,
                                      height: getVerticalSize(26),
                                      width: getHorizontalSize(22),
                                      alignment: Alignment.centerLeft)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 0,
                          margin: getMargin(left: 6),
                          color: ColorConstant.whiteA700,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: ColorConstant.indigo50,
                                  width: getHorizontalSize(1)),
                              borderRadius: BorderRadiusStyle.roundedBorder8),
                          child: Container(
                            height: getVerticalSize(56),
                            width: getHorizontalSize(90),
                            padding: getPadding(
                                left: 31, top: 15, right: 31, bottom: 15),
                            decoration: AppDecoration.outlineIndigo50.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder8),
                            child: Stack(
                              children: [
                                CustomImageView(
                                    svgPath: ImageConstant.imgCibapple,
                                    height: getVerticalSize(26),
                                    width: getHorizontalSize(22),
                                    alignment: Alignment.centerLeft)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () async {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                          padding: getPadding(top: 29, bottom: 5),
                          child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: AppLocalizations.of(context)
                                          .zatenhesabinvarmi,
                                      style: TextStyle(
                                          color: ColorConstant.gray900,
                                          fontSize: getFontSize(15),
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w500,
                                          letterSpacing:
                                              getHorizontalSize(0.15))),
                                  TextSpan(
                                      text: AppLocalizations.of(context)
                                          .simdigirisyap,
                                      style: TextStyle(
                                          color: ColorConstant.cyan400,
                                          fontSize: getFontSize(15),
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w700,
                                          letterSpacing:
                                              getHorizontalSize(0.15)))
                                ],
                              ),
                              textAlign: TextAlign.left)))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Navigates back to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is used
  /// to navigate back to the previous screen.
  onTapBtnArrowleft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the loginScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the `Navigator` widget
  /// to push the named route for the loginScreen.
  CreateAccountWithGoogleAccount(
      {required String fullName,
      required WidgetRef ref,
      required BuildContext context}) async {
    final bool isSuccess =
        await FirebaseAuthServiceMethods(FirebaseAuth.instance)
            .SignInWithGoogle(context, fullName: fullName, isCreatingAcc: true);
    if (isSuccess) {
      CreateProviderDatas(ref: ref, context: context);
    }
  }

  CreateAccountWithMail(
      {required String mail,
      required String password,
      required String fullName,
      required WidgetRef ref,
      required BuildContext context}) async {
    final bool isSuccess =
        await FirebaseAuthServiceMethods(FirebaseAuth.instance).signUpWithEmail(
            fullName: fullName,
            email: mail,
            password: password,
            context: context);
    if (isSuccess) {
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
          profilePicture: '',
          uId: currentUser!.uid,
          fullName: userCollection!["fullName"],
          mail: currentUser.email,
          phone: "",
          isMailVerified: currentUser.emailVerified,
          nickName: '',
          gender: '',
          country: "",
          city: "",
          type: "Öğrenci",
          school: "",
          erasmusSchool: "",
          aboutMe: '',
          skills: '',
          lessons: '',
          chatUsers: {},
        ));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => BottomNavigation(),
      ),
    );
  }
}
