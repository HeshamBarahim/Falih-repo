import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/on_boarding/seconed_page_boarding.dart';
import 'package:falih/src/screens/on_boarding/widget/boarding_button.dart';
import 'package:falih/src/screens/on_boarding/widget/boarding_carousel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstPageBoarding extends StatelessWidget {
  const FirstPageBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgScreen1,
      padding: const EdgeInsets.all(20),
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
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Text(
                          S.of(context).welcome_to,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Text(
                          S.of(context).falih,
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: AppColors.bgScreen1),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            height: 200,
                            width: 150,
                            child: Text(
                              S.of(context).explaination_on_boarding_1,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 20, // Distance from the top
                  right: -80, // Distance from the right
                  child: Image.asset(
                    Images.onBoardingOne,
                    width: 300,
                    height: 300,
                  ),
                )
              ],
            ),
            BoardingButton(onClick: () {
              Get.to(() => const SeconedPageBoarding());
            })
          ],
        ),
      ),
    );
  }
}
