import 'package:carousel_slider/carousel_slider.dart';
import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../config/images.dart';
import '../../../controller/home_controller.dart';

class AdvertiseImgsCarousel extends StatelessWidget {
  AdvertiseImgsCarousel({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1.0,
              // Ensures each item takes the full width
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
              autoPlayInterval: const Duration(seconds: 5),
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                controller.carouselCurrentIndex.value = index;
              }),
          items: Images.home_carousel_images
              .map((imagePath) => ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.fill, // Ensures the image fills the space
                    width: double.infinity, // Takes full width of the carousel
                    height:
                        double.infinity, // Takes full height of the carousel
                  )))
              .toList(),
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .02,
        ),
        Obx(
          () => Center(
            child: AnimatedSmoothIndicator(
              activeIndex: controller.carouselCurrentIndex.value,
              count: Images.home_carousel_images.length,
              effect: const WormEffect(
                  dotHeight: 6,
                  dotWidth: 6,
                  spacing: 10,
                  dotColor: AppColors.lightenMainColor,
                  activeDotColor: AppColors.darkMainColor,
                  paintStyle: PaintingStyle.fill),
            ),
          ),
        )
      ],
    );
  }
}
