import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../../config/color.dart';
import '../../config/font.dart';
import '../../config/routes.dart';
import '../../core/helper/share_preferences.helper.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => OnboardingPageState();
}

class OnboardingPageState extends State<OnboardingPage> {
  final basePath = 'assets/images/svg';

  Future<void> _onDone() async {
    await SharedPreferencesHelper.setOnboarding(true);
    if (!mounted) return;

    context.pushReplacementNamed(RoutersName.login);
  }

  Future<void> _onSkip() async {
    await SharedPreferencesHelper.setOnboarding(true);
    if (!mounted) return;

    context.pushReplacementNamed(RoutersName.login);
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = headerFont.copyWith(
      color: Colors.black,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );
    final bodyStyle = bodyFont.copyWith(
      color: Colors.black,
      fontSize: 16.0,
    );
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50.0),
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'Modern Design',
              body:
                  'Enjoy the modern design of the app, and the best user experience',
              image: SvgPicture.asset('$basePath/onboarding.design.svg'),
              decoration: PageDecoration(
                titleTextStyle: titleStyle,
                bodyTextStyle: bodyStyle,
              ),
            ),
            PageViewModel(
              title: 'Set your notification',
              body:
                  'Set your notification to get the newest task and update from the app',
              image: SvgPicture.asset('$basePath/onboarding.notification.svg'),
              decoration: PageDecoration(
                titleTextStyle: titleStyle,
                bodyTextStyle: bodyStyle,
              ),
            ),
            PageViewModel(
              title: 'Easy to use',
              body:
                  'The app is easy to use, and you can use it anywhere and anytime',
              image: SvgPicture.asset('$basePath/onboarding.statistic.svg'),
              decoration: PageDecoration(
                titleTextStyle: titleStyle,
                bodyTextStyle: bodyStyle,
              ),
            ),
          ],
          showSkipButton: true,
          skip: Text(
            'Skip',
            style: bodyFont.copyWith(color: Colors.black, fontSize: 16.0),
          ),
          next: const Icon(
            Icons.arrow_forward,
            size: 30.0,
            color: secondaryColor,
          ),
          done: Text(
            'Done',
            style: bodyFont.copyWith(color: Colors.black, fontSize: 16.0),
          ),
          onDone: _onDone,
          onSkip: _onSkip,
        ),
      ),
    );
  }
}
