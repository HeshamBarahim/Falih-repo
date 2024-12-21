import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../config/sizes.dart';
import '../../config/themes.dart';
import 'components/on_boarding_views.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});
  static const String sc_route = '/on-boarding-screen';
  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  final controller = PageController();

  bool isLastPage = false;
  bool isFirstPage = true;
  int currentViewsPageIndex = 0;
  LinearGradient currentLinearGradientColor =
      AppColors.aboutUsViewsBorderColor_1;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: SizeConfig.screenHeight! * 0.077,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth! * 0.02),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius:
                    BorderRadius.circular(SizeConfig.screenHeight! * 0.023),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: SizeConfig.screenHeight! * 0.001,
                    offset: Offset(SizeConfig.screenWidth! * 0.002,
                        SizeConfig.screenHeight! * 0.0006),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) =>
                        currentLinearGradientColor.createShader(bounds),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white,
                      iconSize: SizeConfig.screenHeight! * 0.041,
                    ),
                  ),
                  ShaderMask(
                    shaderCallback: (bounds) =>
                        currentLinearGradientColor.createShader(bounds),
                    child: Text(
                      'About Us',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'GoogleFonts.montserratAlternatesTextTheme',
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.screenHeight! * 0.03,
                      ),
                    ),
                  ),
                  ShaderMask(
                    shaderCallback: (bounds) =>
                        currentLinearGradientColor.createShader(bounds),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications),
                      color: Colors.white,
                      iconSize: SizeConfig.screenHeight! * 0.041,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.053,
            ),
            Stack(
              children: [
                Container(
                  height: SizeConfig.screenHeight! * 0.687,
                  width: SizeConfig.screenWidth! * 0.923,
                  decoration: BoxDecoration(
                    gradient: currentLinearGradientColor,
                    borderRadius:
                        BorderRadius.circular(SizeConfig.screenHeight! * 0.026),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth! * 0.01,
                        vertical: SizeConfig.screenHeight! * 0.005),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            SizeConfig.screenHeight! * 0.023),
                      ),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: SizeConfig.screenHeight! * 0.095),
                          child: PageView(
                            controller: controller,
                            onPageChanged: (index) {
                              setState(() {
                                currentViewsPageIndex = index;
                                switch (index) {
                                  case 0:
                                    currentLinearGradientColor =
                                        AppColors.aboutUsViewsBorderColor_1;
                                    break;
                                  case 1:
                                    currentLinearGradientColor =
                                        AppColors.aboutUsViewsBorderColor_2;
                                    break;
                                  case 2:
                                    currentLinearGradientColor =
                                        AppColors.aboutUsViewsBorderColor_3;
                                    break;
                                  case 3:
                                    currentLinearGradientColor =
                                        AppColors.aboutUsViewsBorderColor_4;
                                    break;
                                  case 4:
                                    currentLinearGradientColor =
                                        AppColors.aboutUsViewsBorderColor_5;
                                    break;
                                  default:
                                }
                                isFirstPage = index == 0;
                                isLastPage = index == 4;
                              });
                            },
                            children: [
                              OnBoardingViews(
                                linearGradientColor: currentLinearGradientColor,
                                imgUrl: 'assets/images/logo_falih.png',
                                title: 'Easy to handle',
                                subTitle:
                                    'Easy interfaces and an easy way to interact with it',
                              ),
                              OnBoardingViews(
                                linearGradientColor: currentLinearGradientColor,
                                imgUrl: 'assets/images/logo_falih.png',
                                title: 'trusted',
                                subTitle:
                                    'Always honest and trustworthy in dealing With the client and always taking into account the client\'s circumstances',
                              ),
                              OnBoardingViews(
                                linearGradientColor: currentLinearGradientColor,
                                imgUrl: 'assets/images/logo_falih.png',
                                title: 'Fast Delivery',
                                subTitle:
                                    'Fast Deleviry To Your Location Where Ever It Was And Within A fewer Time Than Any Body Else',
                              ),
                              OnBoardingViews(
                                linearGradientColor: currentLinearGradientColor,
                                imgUrl: 'assets/images/logo_falih.png',
                                title: 'Fast Delivery',
                                subTitle:
                                    'Fast Deleviry To Your Location Where Ever It Was And Within A fewer Time Than Any Body Else',
                              ),
                              OnBoardingViews(
                                linearGradientColor: currentLinearGradientColor,
                                imgUrl: 'assets/images/logo_falih.png',
                                title: 'Fast Delivery',
                                subTitle:
                                    'Fast Deleviry To Your Location Where Ever It Was And Within A fewer Time Than Any Body Else',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: SizeConfig.screenHeight! * 0.071,
                  width: SizeConfig.screenWidth! * 0.583,
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth! * 0.175),
                  decoration: BoxDecoration(
                    gradient: currentLinearGradientColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft:
                          Radius.circular(SizeConfig.screenHeight! * 0.023),
                      bottomRight:
                          Radius.circular(SizeConfig.screenHeight! * 0.023),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'What\'s in Store For you',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.screenHeight! * 0.019,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.036,
            ),
          ],
        ),
      ),
      bottomSheet: isFirstPage
          ? Padding(
              padding: EdgeInsets.only(bottom: SizeConfig.screenHeight! * 0.03),
              child: Container(
                decoration: BoxDecoration(
                  gradient: currentLinearGradientColor,
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenHeight! * 0.023),
                ),
                child: MaterialButton(
                  height: SizeConfig.screenHeight! * 0.059,
                  minWidth: SizeConfig.screenWidth! * 0.73,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(SizeConfig.screenHeight! * 0.023),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.screenHeight! * 0.028,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => controller.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                  ),
                ),
              ),
            )
          : isLastPage
              ? Padding(
                  padding:
                      EdgeInsets.only(bottom: SizeConfig.screenHeight! * 0.03),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: currentLinearGradientColor,
                      borderRadius: BorderRadius.circular(
                          SizeConfig.screenHeight! * 0.023),
                    ),
                    child: MaterialButton(
                      height: SizeConfig.screenHeight! * 0.059,
                      minWidth: SizeConfig.screenWidth! * 0.73,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            SizeConfig.screenHeight! * 0.024),
                      ),
                      child: Text(
                        'Back To Home',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.screenHeight! * 0.028,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth! * 0.048),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: SizeConfig.screenHeight! * 0.03),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: currentLinearGradientColor,
                            borderRadius: BorderRadius.circular(
                                SizeConfig.screenHeight! * 0.023),
                          ),
                          child: MaterialButton(
                            height: SizeConfig.screenHeight! * 0.059,
                            minWidth: SizeConfig.screenWidth! * 0.267,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.screenHeight! * 0.024),
                            ),
                            child: Text(
                              'Back',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.screenHeight! * 0.018,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () => controller.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeOut,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: SizeConfig.screenHeight! * 0.03),
                        child: ShaderMask(
                          shaderCallback: (bounds) =>
                              currentLinearGradientColor.createShader(bounds),
                          child: SmoothPageIndicator(
                            controller: controller,
                            count: 5,
                            effect: WormEffect(
                              dotHeight: SizeConfig.screenHeight! * 0.014,
                              dotWidth: SizeConfig.screenHeight! * 0.014,
                              spacing: SizeConfig.screenWidth! * 0.029,
                              dotColor: Colors.black,
                              activeDotColor: Colors.white,
                              paintStyle: PaintingStyle.stroke,
                            ),
                            onDotClicked: (index) => controller.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: SizeConfig.screenHeight! * 0.03),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: currentLinearGradientColor,
                            borderRadius: BorderRadius.circular(
                                SizeConfig.screenHeight! * 0.023),
                          ),
                          child: MaterialButton(
                            height: SizeConfig.screenHeight! * 0.059,
                            minWidth: SizeConfig.screenWidth! * 0.267,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.screenHeight! * 0.024),
                            ),
                            child: Text(
                              'Next',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.screenHeight! * 0.018,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () => controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeOut,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
