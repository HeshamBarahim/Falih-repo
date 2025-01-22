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
    final displayWidth = MediaQuery.of(context).size.width;
    final displayHeight = displayWidth / 2;
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
          items: Images.homeCarouselImages
              .map((imagePath) => ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image(
                      image: ResizeImage(
                        AssetImage(imagePath),
                        width: displayWidth.toInt(),
                        height: displayHeight.toInt(),
                      ),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ))
              .toList(),
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .02,
        ),
        Obx(
          () => Center(
            child: AnimatedSmoothIndicator(
              activeIndex: controller.carouselCurrentIndex.value,
              count: Images.homeCarouselImages.length,
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
