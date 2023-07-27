import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/connect_plus_user.dart';
import '../homepage/bottom_navigation_bar.dart';

class CenterNextButton extends StatelessWidget {
  final AnimationController animationController;
  final VoidCallback onNextClick;
  const CenterNextButton(
      {Key? key, required this.animationController, required this.onNextClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _topMoveAnimation =
        Tween<Offset>(begin: Offset(0, 5), end: Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _signUpMoveAnimation =
        Tween<double>(begin: 0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _loginTextMoveAnimation =
        Tween<Offset>(begin: Offset(0, 5), end: Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    return Padding(
      padding:
          EdgeInsets.only(bottom: 1 + MediaQuery.of(context).padding.bottom),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SlideTransition(
            position: _topMoveAnimation,
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) => AnimatedOpacity(
                opacity: animationController.value >= 0.2 &&
                        animationController.value <= 0.6
                    ? 1
                    : 0,
                duration: Duration(milliseconds: 480),
                child: _pageView(),
              ),
            ),
          ),
          SlideTransition(
            position: _topMoveAnimation,
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) => Padding(
                padding: EdgeInsets.only(
                    bottom: 38 - (38 * _signUpMoveAnimation.value)),
                child: Container(
                  height: 58,
                  width: 58 + (200 * _signUpMoveAnimation.value),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        8 + 32 * (1 - _signUpMoveAnimation.value)),
                    color: _signUpMoveAnimation.value > 0.7
                        ? Color.fromARGB(
                            255, 82, 51, 24) // Change color on the fourth page
                        : Color.fromARGB(
                            255, 251, 141, 39), // Default color for other pages
                  ),
                  child: PageTransitionSwitcher(
                    duration: Duration(milliseconds: 480),
                    reverse: _signUpMoveAnimation.value < 0.7,
                    transitionBuilder: (
                      Widget child,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                    ) {
                      return SharedAxisTransition(
                        fillColor: Colors.transparent,
                        child: child,
                        animation: animation,
                        secondaryAnimation: secondaryAnimation,
                        transitionType: SharedAxisTransitionType.vertical,
                      );
                    },
                    child: _signUpMoveAnimation.value > 0.7
                        ? InkWell(
                            onTap: onNextClick,
                            child: Padding(
                              padding: EdgeInsets.only(left: 16.0, right: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Haydi Başlayalım',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: onNextClick,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.arrow_forward_ios_rounded,
                                  color: Colors.black, size: 18),
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: SlideTransition(
              position: _loginTextMoveAnimation,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Kayıt olmadan ',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool('isOnboardingShown', false);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => BottomNavigation(),
                        ),
                      );
                    },
                    child: Text(
                      'Devam et!',
                      style: TextStyle(
                        color: Color.fromARGB(255, 53, 194, 193),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        ],
      ),
    );
  }

  Widget _pageView() {
    int _selectedIndex = 0;

    if (animationController.value >= 0.7) {
      _selectedIndex = 3;
    } else if (animationController.value >= 0.5) {
      _selectedIndex = 2;
    } else if (animationController.value >= 0.3) {
      _selectedIndex = 1;
    } else if (animationController.value >= 0.1) {
      _selectedIndex = 0;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < 3; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 480),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: _selectedIndex == i
                      ? Color.fromARGB(255, 7, 7, 7)
                      : Color.fromARGB(255, 212, 208, 208),
                ),
                width: _selectedIndex == i ? 12 : 6,
                height: _selectedIndex == i ? 12 : 6,
              ),
            )
        ],
      ),
    );
  }

  Future<void> CreateProviderDatas(
      {required WidgetRef ref, required BuildContext context}) async {
    ref.read(userProvider.notifier).LogOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => BottomNavigation(),
      ),
    );
  }
}
