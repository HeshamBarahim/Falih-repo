import 'package:falih/src/controller/back_press_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/on_boarding/seconed_page_boarding.dart';
import 'package:falih/src/screens/on_boarding/widget/boarding_button.dart';
import 'package:falih/src/screens/on_boarding/widget/boarding_carousel.dart';
import '../../config/sizes.dart';

class FirstPageBoarding extends StatelessWidget {
  const FirstPageBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime? lastBackPressTime;
    //  Current language code
    final locale = Localizations.localeOf(context).languageCode;
    // Check if the language is Arabic
    final isArabic = locale == 'ar';
    SizeConfig().init(context);
    return PopScope(
      canPop: false, // Prevent default back navigation
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;

        DateTime now = DateTime.now();
        if (lastBackPressTime == null ||
            now.difference(lastBackPressTime!) > const Duration(seconds: 2)) {
          lastBackPressTime = now;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth! * 0.04,
                vertical: SizeConfig.screenHeight! * 0.01,
              ),
              content: Text(
                'Press back again to exit The App',
                style: TextStyle(
                  fontSize: SizeConfig.screenHeight! * 0.015,
                  color: Colors.white,
                ),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        } else {
          Get.back();
        }
      },
      child: Container(
        color: AppColors.bgScreen1,
        padding: EdgeInsets.all(SizeConfig.screenWidth! * 0.05),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BoardingCarousel(
                fColor: Colors.white,
                sColor: Colors.white.withOpacity(0.5),
                tColor: Colors.white.withOpacity(0.5),
              ),
              Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    padding: EdgeInsets.all(SizeConfig.screenWidth! * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: SizeConfig.screenWidth! * 0.05),
                          child: Text(
                            S.of(context).welcome_to,
                            style: TextStyle(
                              fontSize: SizeConfig.screenHeight! * 0.03,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: SizeConfig.screenWidth! * 0.05),
                          child: Text(
                            S.of(context).falih,
                            style: TextStyle(
                              fontSize: SizeConfig.screenHeight! * 0.03,
                              fontWeight: FontWeight.bold,
                              color: AppColors.bgScreen1,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight! * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: SizeConfig.screenWidth! * 0.05),
                              height: SizeConfig.screenHeight! * 0.25,
                              width: SizeConfig.screenWidth! * 0.4,
                              child: Text(
                                S.of(context).explaination_on_boarding_1,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeConfig.screenHeight! * 0.02,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: SizeConfig.screenHeight! * 0.02,
                    right: isArabic
                        ? SizeConfig.screenWidth! * 0.3
                        : -SizeConfig.screenWidth! * 0.2,
                    child: Image.asset(
                      Images.onBoardingOne,
                      width: SizeConfig.screenWidth! * 0.75,
                      height: SizeConfig.screenHeight! * 0.35,
                    ),
                  ),
                ],
              ),
              BoardingButton(onClick: () {
                Get.to(() => const SeconedPageBoarding());
              }),
            ],
          ),
        ),
      ),
    );
  }
}
