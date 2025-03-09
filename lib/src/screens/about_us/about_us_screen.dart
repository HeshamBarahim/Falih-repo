import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../config/sizes.dart';
import '../../config/themes.dart';
import 'components/on_boarding_views.dart';
import 'controller/about_us_screen_contoller.dart';

class AboutUsScreen extends StatelessWidget {
  AboutUsScreen({super.key});

  final AboutUsScreenController aboutUsScreenController =
      Get.put(AboutUsScreenController());

  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Obx(
      () => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            Get.back();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              S.of(context).about_us,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64),
            child: Stack(
              children: [
                Container(
                  height: SizeConfig.screenHeight! * 0.6,
                  width: SizeConfig.screenWidth! * 1,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: aboutUsScreenController
                        .currentLinearGradientColor.value,
                    borderRadius:
                        BorderRadius.circular(SizeConfig.screenHeight! * 0.026),
                  ),
                  child: Center(
                    child: PageView(
                      controller: pageController,
                      onPageChanged: (index) {
                        aboutUsScreenController.currentViewsPageIndex.value =
                            index;
                        switch (index) {
                          case 0:
                            aboutUsScreenController.currentLinearGradientColor
                                .value = AppColors.aboutUsViewsBorderColor_1;
                            break;
                          case 1:
                            aboutUsScreenController.currentLinearGradientColor
                                .value = AppColors.aboutUsViewsBorderColor_2;
                            break;
                          case 2:
                            aboutUsScreenController.currentLinearGradientColor
                                .value = AppColors.aboutUsViewsBorderColor_3;
                            break;
                          case 3:
                            aboutUsScreenController.currentLinearGradientColor
                                .value = AppColors.aboutUsViewsBorderColor_4;
                            break;
                          case 4:
                            aboutUsScreenController.currentLinearGradientColor
                                .value = AppColors.aboutUsViewsBorderColor_5;
                            break;
                          default:
                        }
                        aboutUsScreenController.isFirstPage.value = index == 0;
                        aboutUsScreenController.isLastPage.value = index == 4;
                      },
                      children: [
                        OnBoardingViews(
                          linearGradientColor: aboutUsScreenController
                              .currentLinearGradientColor.value,
                          imgUrl: Images.classBoy,
                          width: SizeConfig.screenWidth! * 0.50,
                          height: SizeConfig.screenWidth! * 0.50,
                          title: S.of(context).easy_use,
                          subTitle: S.of(context).subTitle_easy,
                        ),
                        OnBoardingViews(
                          linearGradientColor: aboutUsScreenController
                              .currentLinearGradientColor.value,
                          imgUrl: Images.community,
                          width: SizeConfig.screenWidth! * 0.50,
                          height: SizeConfig.screenWidth! * 0.50,
                          title: S.of(context).trusted,
                          subTitle: S.of(context).subTitle_trusted,
                        ),
                        OnBoardingViews(
                          linearGradientColor: aboutUsScreenController
                              .currentLinearGradientColor.value,
                          imgUrl: Images.magicBook,
                          width: SizeConfig.screenWidth! * 0.50,
                          height: SizeConfig.screenWidth! * 0.50,
                          title: S.of(context).quick_access,
                          subTitle: S.of(context).subTitle_quick,
                        ),
                        OnBoardingViews(
                          linearGradientColor: aboutUsScreenController
                              .currentLinearGradientColor.value,
                          imgUrl: Images.achievement,
                          width: SizeConfig.screenWidth! * 0.50,
                          height: SizeConfig.screenWidth! * 0.50,
                          title: S.of(context).compete_shine,
                          subTitle: S.of(context).subTitle_compete,
                        ),
                        OnBoardingViews(
                          linearGradientColor: aboutUsScreenController
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
                Container(
                  height: SizeConfig.screenHeight! * 0.071,
                  width: SizeConfig.screenWidth! * 0.583,
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth! * 0.175),
                  decoration: BoxDecoration(
                    gradient: aboutUsScreenController
                        .currentLinearGradientColor.value,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      S.of(context).your_journey,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomSheet: aboutUsScreenController.isFirstPage.value
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: aboutUsScreenController
                          .currentLinearGradientColor.value,
                      borderRadius: BorderRadius.circular(8),
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
                      ),
                      onPressed: () => pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                      ),
                    ),
                  ),
                )
              : aboutUsScreenController.isLastPage.value
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: MaterialButton(
                        height: SizeConfig.screenHeight! * 0.059,
                        minWidth: SizeConfig.screenWidth! * 0.73,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              SizeConfig.screenHeight! * 0.024),
                        ),
                        child: Text(
                          S.of(context).back_to_home,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Get.isDarkMode
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).primaryColor,
                              ),
                        ),
                        onPressed: () {
                          Get.toNamed("main-screen");
                          aboutUsScreenController.currentViewsPageIndex.value =
                              0;
                          aboutUsScreenController.isFirstPage.value = true;
                          pageController.jumpTo(0);
                        },
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: aboutUsScreenController
                                  .currentLinearGradientColor.value,
                              borderRadius: BorderRadius.circular(8),
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
                              ),
                              onPressed: () => pageController.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOut,
                              ),
                            ),
                          ),
                          ShaderMask(
                            shaderCallback: (bounds) => aboutUsScreenController
                                .currentLinearGradientColor.value
                                .createShader(bounds),
                            child: SmoothPageIndicator(
                              controller: pageController,
                              count: 5,
                              effect: WormEffect(
                                dotHeight: SizeConfig.screenHeight! * 0.014,
                                dotWidth: SizeConfig.screenHeight! * 0.014,
                                spacing: SizeConfig.screenWidth! * 0.029,
                                dotColor: Colors.black,
                                activeDotColor: Colors.white,
                                paintStyle: PaintingStyle.stroke,
                              ),
                              onDotClicked: (index) =>
                                  pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: aboutUsScreenController
                                  .currentLinearGradientColor.value,
                              borderRadius: BorderRadius.circular(8),
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
                              ),
                              onPressed: () => pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOut,
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
