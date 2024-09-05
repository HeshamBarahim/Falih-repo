import 'package:carousel_slider/carousel_slider.dart';
import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({
    super.key,
    required this.images,
  });
  final List<Widget> images;
  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            options: CarouselOptions(
                autoPlay: false,
                // height: double.infinity,
                viewportFraction: 1,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                autoPlayInterval: const Duration(seconds: 5),
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                }),
            items: widget.images),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: AnimatedSmoothIndicator(
            activeIndex: currentIndex,
            count: widget.images.length,
            effect: const WormEffect(
                dotHeight: 6,
                dotWidth: 6,
                spacing: 10,
                dotColor: AppColors.shadowColor,
                activeDotColor: Colors.red,
                paintStyle: PaintingStyle.fill),
          ),
        )
      ],
    );
  }
}
