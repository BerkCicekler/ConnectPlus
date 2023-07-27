import '../../../core/utils/color_constant.dart';
import '../../../core/utils/image_constant.dart';
import '../../../core/utils/size_utils.dart';
import '../../../theme/app_style.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.orange700,
            body: SizedBox(
                width: double.maxFinite,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: SingleChildScrollView(
                              child: Padding(
                                  padding: getPadding(left: 2),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CustomImageView(
                                            imagePath: ImageConstant.imgArrowleft,
                                            height: getVerticalSize(133),
                                            width: getHorizontalSize(294),
                                            alignment: Alignment.centerRight),
                                        CustomImageView(
                                            svgPath: ImageConstant.imgCheckmark,
                                            height: getSize(100),
                                            width: getSize(100),
                                            margin: getMargin(top: 114)),
                                        Padding(
                                            padding: getPadding(top: 37),
                                            child: Text("Password Changed!",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtUrbanistRomanBold26)),
                                        Container(
                                            width: getHorizontalSize(226),
                                            margin: getMargin(top: 6),
                                            child: Text(
                                                "Your password has been changed successfully.",
                                                maxLines: null,
                                                textAlign: TextAlign.center,
                                                style: AppStyle
                                                    .txtUrbanistRomanMedium15)),
                                        CustomButton(
                                            height: getVerticalSize(56),
                                            text: "Back to Login",
                                            margin: getMargin(
                                                left: 20, top: 38, right: 22),
                                            onTap: () {

                                            }),
                                        CustomImageView(
                                            svgPath: ImageConstant.imgGoogleic,
                                            height: getVerticalSize(111),
                                            width: getHorizontalSize(372),
                                            margin: getMargin(top: 137))
                                      ]))))
                    ]))));
  }

  /// Navigates to the loginScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the `Navigator` widget
  /// to push the named route for the loginScreen.

}
