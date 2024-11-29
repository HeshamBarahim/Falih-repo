import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/Auth/login/login.dart';
import 'package:falih/src/screens/on_boarding/widget/boarding_button.dart';
import 'package:falih/src/screens/on_boarding/widget/boarding_carousel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThirdPageBoarding extends StatelessWidget {
  const ThirdPageBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return Container(
      color: AppColors.bgScreen3,
      padding: const EdgeInsets.all(20),
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
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        height: 250,
                        width: 350,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(S.of(context).equip,
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            Text(S.of(context).your_self,
                                style: const TextStyle(
                                    color: AppColors.bgScreen3,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold)),
                            Text(S.of(context).with_the,
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            Text(S.of(context).best_tools,
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.bgScreen3))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -20, // Distance from the top
                  right: -60, // Distance from the right
                  child: Image.asset(
                    Images.onBoardingThree,
                    width: 300,
                    height: 300,
                  ),
                )
              ],
            ),
            BoardingButton(onClick: () {
              // Save state to skip onboarding in the future
              box.write('hasSeenOnboarding', true);
              Get.to(() => Login());
            })
          ],
        ),
      ),
    );
  }
}
