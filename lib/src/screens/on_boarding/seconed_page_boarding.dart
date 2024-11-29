import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/on_boarding/third_page_boarding.dart';
import 'package:falih/src/screens/on_boarding/widget/boarding_button.dart';
import 'package:falih/src/screens/on_boarding/widget/boarding_carousel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeconedPageBoarding extends StatelessWidget {
  const SeconedPageBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgScreen2,
      padding: const EdgeInsets.all(20),
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
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: 250,
                          width: 350,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(S.of(context).learn,
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                              Text(S.of(context).your,
                                  style: const TextStyle(
                                      color: AppColors.bgScreen2,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                              Text(S.of(context).way,
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold))
                            ],
                          )),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -20, // Distance from the top
                  right: -10, // Distance from the right
                  child: Image.asset(
                    Images.onBoardingTwo,
                    width: 300,
                    height: 300,
                  ),
                )
              ],
            ),
            BoardingButton(onClick: () {
              Get.to(() => const ThirdPageBoarding());
            })
          ],
        ),
      ),
    );
  }
}
