import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/Auth/login/login.dart';
import 'package:falih/src/screens/on_boarding/widget/boarding_button.dart';
import 'package:falih/src/screens/on_boarding/widget/boarding_carousel.dart';

import '../../config/sizes.dart';

class ThirdPageBoarding extends StatelessWidget {
  const ThirdPageBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    SizeConfig().init(context);
    return Container(
      color: AppColors.bgScreen3,
      padding: EdgeInsets.all(SizeConfig.screenWidth! * 0.05),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const BoardingCarousel(
              fColor: Colors.white,
              sColor: Colors.white,
              tColor: Colors.white,
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
                              S.of(context).equip,
                              style: TextStyle(
                                fontSize: SizeConfig.screenHeight! * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              S.of(context).your_self,
                              style: TextStyle(
                                color: AppColors.bgScreen3,
                                fontSize: SizeConfig.screenHeight! * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              S.of(context).with_the,
                              style: TextStyle(
                                fontSize: SizeConfig.screenHeight! * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              S.of(context).best_tools,
                              style: TextStyle(
                                fontSize: SizeConfig.screenHeight! * 0.04,
                                fontWeight: FontWeight.bold,
                                color: AppColors.bgScreen3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -SizeConfig.screenHeight! * 0.025,
                  right: -SizeConfig.screenWidth! * 0.15,
                  child: Image.asset(
                    Images.onBoardingThree,
                    width: SizeConfig.screenWidth! * 0.75,
                    height: SizeConfig.screenHeight! * 0.35,
                  ),
                ),
              ],
            ),
            BoardingButton(onClick: () {
              box.write('hasSeenOnboarding', true);
              Get.offAll(() => Login());
            }),
          ],
        ),
      ),
    );
  }
}
