import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Get.toNamed(AppRoutes.loginScreen);
  }

  /* Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  } */

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/intro/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = UITextStyle.normalMeduim;

    var pageDecoration = PageDecoration(
      imageFlex: 2,
      bodyFlex: 1,
      imageAlignment: Alignment.center,
      bodyAlignment: Alignment.center,
      titleTextStyle: UITextStyle.boldHeading.apply(color: UIColors.primary),
      bodyTextStyle: bodyStyle.apply(
        color: UIColors.white,
      ),
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: const Color.fromARGB(255, 73, 74, 116),
      imagePadding: const EdgeInsets.all(50),
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: const Color.fromARGB(255, 73, 74, 116),
      allowImplicitScrolling: true,
      autoScrollDuration: 4000,

      /* globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          child: const Text(
            'Let\'s go right away!',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _onIntroEnd(context),
        ),
      ), */
      pages: [
        PageViewModel(
          title: "حساباتك في مكان واحد",
          body:
              "حسابات الزبائن , جرد الصناديق والبضاعة  \n \n  والكثير في انتظارك",
          image: _buildImage('calc.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "لا يهم إن كنت محاسباً",
          body: "تم تجهيز التطبيق بأسلوب سهل وبسيط ",
          image: _buildImage('personal_finance.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "التقارير المالية",
          body: "راقب أرباحك ومصاريفك أولاً بأول",
          image: _buildImage('finance.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "تابع موظفيك عن بعد",
          body: "إشعارات آنية لكل عملية محاسبية ستصلك لهاتفك",
          image: _buildImage('message.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "زامن البيانات على أي منصة",
          body: "يمكنك التعامل مع تطبيق ويب \n \n  مع مزامنة كاملة للبيانات",
          image: _buildImage('sync.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "بياناتك في أمان",
          body: "تشفير تام للبيانات بين المخدمات والتطبيق",
          image: _buildImage('encryption.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(
        Icons.arrow_back,
        color: UIColors.white,
      ),
      skip: const Text('تجاوز', style: UITextStyle.normalMeduim),
      next: const Icon(Icons.arrow_forward, color: UIColors.white),
      done: const Text('تم', style: UITextStyle.normalMeduim),
      curve: Curves.easeInExpo,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: UIColors.primary,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
