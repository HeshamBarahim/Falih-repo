import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/on_boarding/third_page_boarding.dart';
import 'package:falih/src/screens/on_boarding/widget/boarding_button.dart';
import 'package:falih/src/screens/on_boarding/widget/boarding_carousel.dart';

import '../../config/sizes.dart';

class SeconedPageBoarding extends StatelessWidget {
  const SeconedPageBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: AppColors.bgScreen2,
      padding: EdgeInsets.all(SizeConfig.screenWidth! * 0.05),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BoardingCarousel(
              fColor: Colors.white,
              sColor: Colors.white,
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
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.1,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: SizeConfig.screenWidth! * 0.05),
                        height: SizeConfig.screenHeight! * 0.3,
                        width: SizeConfig.screenWidth! * 0.85,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).learn,
                              style: TextStyle(
                                fontSize: SizeConfig.screenHeight! * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              S.of(context).your,
                              style: TextStyle(
                                color: AppColors.bgScreen2,
                                fontSize: SizeConfig.screenHeight! * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              S.of(context).way,
                              style: TextStyle(
                                fontSize: SizeConfig.screenHeight! * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -SizeConfig.screenHeight! * 0.02,
                  right: -SizeConfig.screenWidth! * 0.02,
                  child: Image.asset(
                    Images.onBoardingTwo,
                    width: SizeConfig.screenWidth! * 0.75,
                    height: SizeConfig.screenHeight! * 0.35,
                  ),
                )
              ],
            ),
            BoardingButton(onClick: () {
              Get.to(() => const ThirdPageBoarding());
            }),
          ],
        ),
      ),
    );
  }
}
