import 'package:erasmus_connect/core/app_export.dart';
import 'package:erasmus_connect/screens/registeration_login/login_screen/login_screen.dart';
import 'package:erasmus_connect/widgets/custom_button.dart';
import 'package:erasmus_connect/widgets/custom_icon_button.dart';
import 'package:erasmus_connect/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../services/auth.dart';

// ignore_for_file: must_be_immutable
class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                        padding: getPadding(
                            left: 39, top: 58, right: 39, bottom: 58),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomIconButton(
                                  height: 41,
                                  width: 41,
                                  margin: getMargin(left: 12),
                                  onTap: () {
                                    onTapBtnArrowleft(context);
                                  },
                                  child: CustomImageView(
                                      svgPath: ImageConstant.imgArrowleft)),
                              Padding(
                                  padding: getPadding(top: 32),
                                  child: Text("Şifreni mi unuttun?",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtUrbanistRomanBold30)),
                              Container(
                                  width: getHorizontalSize(292),
                                  margin: getMargin(top: 17),
                                  child: Text(
                                      "Sorun yok! Lütfen hesabınızla bağlantılı e-posta adresini girin.",
                                      maxLines: null,
                                      textAlign: TextAlign.left,
                                      style:
                                          AppStyle.txtUrbanistRomanMedium16)),
                              CustomTextFormField(
                                  focusNode: FocusNode(),
                                  autofocus: true,
                                  controller: emailController,
                                  hintText: "Email adresini gir",
                                  margin: getMargin(left: 6, top: 27, right: 1),
                                  textInputAction: TextInputAction.done,
                                  textInputType: TextInputType.emailAddress),
                              CustomButton(
                                  onTap: () {
                                    SendForgotPasswordMail(
                                        mail: emailController.text,
                                        context: context);
                                  },
                                  height: getVerticalSize(56),
                                  text: "Kod gönder",
                                  margin: getMargin(left: 5, top: 29)),
                              Spacer(),
                              Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: getPadding(bottom: 45),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen(),
                                            ),
                                          );
                                        },
                                        child: RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text:
                                                      "Şifreni hatırladın mı? ",
                                                  style: TextStyle(
                                                      color:
                                                          ColorConstant.gray900,
                                                      fontSize: getFontSize(15),
                                                      fontFamily: 'Urbanist',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing:
                                                          getHorizontalSize(
                                                              0.15))),
                                              TextSpan(
                                                  text: "Giriş yap",
                                                  style: TextStyle(
                                                      color:
                                                          ColorConstant.cyan400,
                                                      fontSize: getFontSize(15),
                                                      fontFamily: 'Urbanist',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      letterSpacing:
                                                          getHorizontalSize(
                                                              0.15)))
                                            ]),
                                            textAlign: TextAlign.left),
                                      )))
                            ]))))));
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
  void SendForgotPasswordMail(
      {required String mail, required BuildContext context}) {
    FirebaseAuthServiceMethods(FirebaseAuth.instance)
        .ForgotPassword(mail: mail, context: context);
  }
}
