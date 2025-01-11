import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../config/sizes.dart';
import '../../config/themes.dart';
import '../main_screen/main_screen.dart';
import 'components/on_boarding_views.dart';
import 'controller/about_us_screen_contoller.dart';

class AboutUsScreen extends StatelessWidget {
  AboutUsScreen({super.key});
  // static const String sc_route = '/on-boarding-screen';

  final AboutUsScreenContoller aboutUsScreenContoller =
      Get.put(AboutUsScreenContoller());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Obx(
      () => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            // Navigate to the menu screen when the user tries to pop
            Get.offAll( MainScreen());
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  height: SizeConfig.screenHeight! * 0.077,
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth! * 0.02),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
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
                      SizedBox(
                        width: SizeConfig.screenWidth! * 0.10,
                      ),
                      ShaderMask(
                        shaderCallback: (bounds) => aboutUsScreenContoller
                            .currentLinearGradientColor.value
                            .createShader(bounds),
                        child: Text(
                          S.of(context).about_us,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily:
                                'GoogleFonts.montserratAlternatesTextTheme',
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.screenHeight! * 0.03,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.screenWidth! * 0.10,
                      )
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
                        gradient: aboutUsScreenContoller
                            .currentLinearGradientColor.value,
                        borderRadius: BorderRadius.circular(
                            SizeConfig.screenHeight! * 0.026),
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
                                controller:
                                    aboutUsScreenContoller.pageController,
                                onPageChanged: (index) {
                                  aboutUsScreenContoller
                                      .currentViewsPageIndex.value = index;
                                  switch (index) {
                                    case 0:
                                      aboutUsScreenContoller
                                              .currentLinearGradientColor
                                              .value =
                                          AppColors.aboutUsViewsBorderColor_1;
                                      break;
                                    case 1:
                                      aboutUsScreenContoller
                                              .currentLinearGradientColor
                                              .value =
                                          AppColors.aboutUsViewsBorderColor_2;
                                      break;
                                    case 2:
                                      aboutUsScreenContoller
                                              .currentLinearGradientColor
                                              .value =
                                          AppColors.aboutUsViewsBorderColor_3;
                                      break;
                                    case 3:
                                      aboutUsScreenContoller
                                              .currentLinearGradientColor
                                              .value =
                                          AppColors.aboutUsViewsBorderColor_4;
                                      break;
                                    case 4:
                                      aboutUsScreenContoller
                                              .currentLinearGradientColor
                                              .value =
                                          AppColors.aboutUsViewsBorderColor_5;
                                      break;
                                    default:
                                  }
                                  aboutUsScreenContoller.isFirstPage.value =
                                      index == 0;
                                  aboutUsScreenContoller.isLastPage.value =
                                      index == 4;
                                },
                                children: [
                                  OnBoardingViews(
                                    linearGradientColor: aboutUsScreenContoller
                                        .currentLinearGradientColor.value,
                                    imgUrl: Images.classBoy,
                                    width: SizeConfig.screenWidth! * 0.50,
                                    height: SizeConfig.screenWidth! * 0.50,
                                    title: S.of(context).easy_use,
                                    subTitle: S.of(context).subTitle_easy,
                                  ),
                                  OnBoardingViews(
                                    linearGradientColor: aboutUsScreenContoller
                                        .currentLinearGradientColor.value,
                                    imgUrl: Images.community,
                                    width: SizeConfig.screenWidth! * 0.50,
                                    height: SizeConfig.screenWidth! * 0.50,
                                    title: S.of(context).trusted,
                                    subTitle: S.of(context).subTitle_trusted,
                                  ),
                                  OnBoardingViews(
                                    linearGradientColor: aboutUsScreenContoller
                                        .currentLinearGradientColor.value,
                                    imgUrl: Images.magicBook,
                                    width: SizeConfig.screenWidth! * 0.50,
                                    height: SizeConfig.screenWidth! * 0.50,
                                    title: S.of(context).quick_access,
                                    subTitle: S.of(context).subTitle_quick,
                                  ),
                                  OnBoardingViews(
                                    linearGradientColor: aboutUsScreenContoller
                                        .currentLinearGradientColor.value,
                                    imgUrl: Images.achievement,
                                    width: SizeConfig.screenWidth! * 0.50,
                                    height: SizeConfig.screenWidth! * 0.50,
                                    title: S.of(context).compete_shine,
                                    subTitle: S.of(context).subTitle_compete,
                                  ),
                                  OnBoardingViews(
                                    linearGradientColor: aboutUsScreenContoller
                                        .currentLinearGradientColor.value,
                                    imgUrl: Images.sucess,
                                    width: SizeConfig.screenWidth! * 0.50,
                                    height: SizeConfig.screenWidth! * 0.50,
                                    title: S.of(context).achieve_your_best,
                                    subTitle: S.of(context).achieveTitle,
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
                        gradient: aboutUsScreenContoller
                            .currentLinearGradientColor.value,
                        borderRadius: BorderRadius.only(
                          bottomLeft:
                              Radius.circular(SizeConfig.screenHeight! * 0.023),
                          bottomRight:
                              Radius.circular(SizeConfig.screenHeight! * 0.023),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          S.of(context).your_journey,
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
          bottomSheet: aboutUsScreenContoller.isFirstPage.value
              ? Padding(
                  padding:
                      EdgeInsets.only(bottom: SizeConfig.screenHeight! * 0.03),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: aboutUsScreenContoller
                          .currentLinearGradientColor.value,
                      borderRadius: BorderRadius.circular(
                          SizeConfig.screenHeight! * 0.023),
                    ),
                    child: MaterialButton(
                      height: SizeConfig.screenHeight! * 0.059,
                      minWidth: SizeConfig.screenWidth! * 0.73,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            SizeConfig.screenHeight! * 0.023),
                      ),
                      child: Text(
                        S.of(context).next,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.screenHeight! * 0.028,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () =>
                          aboutUsScreenContoller.pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                      ),
                    ),
                  ),
                )
              : aboutUsScreenContoller.isLastPage.value
                  ? Padding(
                      padding: EdgeInsets.only(
                          bottom: SizeConfig.screenHeight! * 0.03),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: aboutUsScreenContoller
                              .currentLinearGradientColor.value,
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
                            S.of(context).back_to_home,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.screenHeight! * 0.028,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Get.offAll(() =>  MainScreen());
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
                                gradient: aboutUsScreenContoller
                                    .currentLinearGradientColor.value,
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
                                  S.of(context).back,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeConfig.screenHeight! * 0.018,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () => aboutUsScreenContoller
                                    .pageController
                                    .previousPage(
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
                              shaderCallback: (bounds) => aboutUsScreenContoller
                                  .currentLinearGradientColor.value
                                  .createShader(bounds),
                              child: SmoothPageIndicator(
                                controller:
                                    aboutUsScreenContoller.pageController,
                                count: 5,
                                effect: WormEffect(
                                  dotHeight: SizeConfig.screenHeight! * 0.014,
                                  dotWidth: SizeConfig.screenHeight! * 0.014,
                                  spacing: SizeConfig.screenWidth! * 0.029,
                                  dotColor: Colors.black,
                                  activeDotColor: Colors.white,
                                  paintStyle: PaintingStyle.stroke,
                                ),
                                onDotClicked: (index) => aboutUsScreenContoller
                                    .pageController
                                    .animateToPage(
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
                                gradient: aboutUsScreenContoller
                                    .currentLinearGradientColor.value,
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
                                  S.of(context).next,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeConfig.screenHeight! * 0.018,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () => aboutUsScreenContoller
                                    .pageController
                                    .nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeOut,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
