import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../widgets/bottom_navigator_bar.dart';
import 'adventure.dart';
import 'connect.dart';
import 'explore.dart';
import 'getstarted.dart';
import 'next_button.dart';

class IntroductionAnimationScreen extends ConsumerStatefulWidget {
  const IntroductionAnimationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<IntroductionAnimationScreen> createState() =>
      _IntroductionAnimationScreenState();
}

class _IntroductionAnimationScreenState
    extends ConsumerState<IntroductionAnimationScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Color _backgroundColor; // Added variable to store the background color

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 8))
          ..addListener(
              _onAnimationValueChanged); // Add listener to track value changes
    _animationController.animateTo(0.2);
    _backgroundColor =
        _getBackgroundColor(0.2); // Initialize the background color
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor, // Use the stored background color
      body: ClipRect(
        child: Stack(
          children: [
            ExploreView(
              animationController: _animationController,
            ),
            ConnectView(
              animationController: _animationController,
            ),
            AdventureView(
              animationController: _animationController,
            ),
            GetstartedView(
              animationController: _animationController,
            ),
            CenterNextButton(
              animationController: _animationController,
              onNextClick: _onNextClick,
            ),
          ],
        ),
      ),
    );
  }

  void _onAnimationValueChanged() {
    setState(() {
      // Update the background color when the animation value changes
      _backgroundColor = _getBackgroundColor(_animationController.value);
    });
  }

  Color _getBackgroundColor(double animationValue) {
    // Return different background colors based on the animation value
    if (animationValue >= 0.0 && animationValue < 0.2) {
      return Color.fromARGB(
          255, 247, 235, 225); // Example background color for the first page
    } else if (animationValue >= 0.2 && animationValue < 0.4) {
      return Color.fromARGB(
          255, 247, 235, 225); // Example background color for the second page
    } else if (animationValue >= 0.4 && animationValue < 0.6) {
      return Color.fromARGB(
          255, 247, 235, 225); // Example background color for the third page
    } else if (animationValue >= 0.6 && animationValue < 0.8) {
      return Color.fromARGB(
          255, 247, 235, 225); // Example background color for the fourth page
    } else {
      return Color.fromARGB(
          255, 247, 235, 225); // Example background color for the fifth page
    }
  }

  void _onNextClick() {
    if (_animationController.value >= 0 && _animationController.value <= 0.2) {
      _animationController.animateTo(0.4);
    } else if (_animationController.value > 0.2 &&
        _animationController.value <= 0.4) {
      _animationController.animateTo(0.6);
    } else if (_animationController.value > 0.4 &&
        _animationController.value <= 0.6) {
      _animationController.animateTo(0.8);
    } else if (_animationController.value > 0.6 &&
        _animationController.value <= 0.8) {
      _signUpClick();
    }
  }

  Future<void> _signUpClick() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isOnboardingShown', false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyApp(isIntroduction: false,)),
    );
  }
}
