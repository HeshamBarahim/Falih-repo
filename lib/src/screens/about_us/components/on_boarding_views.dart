import 'package:flutter/material.dart';

import '../../../config/sizes.dart';

class OnBoardingViews extends StatelessWidget {
  final LinearGradient linearGradientColor;
  final String imgUrl;
  final String title;
  final String subTitle;
  final double width;
  final double height;

  const OnBoardingViews(
      {super.key,
      required this.linearGradientColor,
      required this.imgUrl,
      required this.title,
      required this.subTitle,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth! * 0.02,
          vertical: SizeConfig.screenHeight! * 0.02),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(SizeConfig.screenWidth! * 0.05),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: SizeConfig.screenHeight! * 0.02),
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return linearGradientColor.createShader(bounds);
              },
              blendMode: BlendMode.srcIn,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: SizeConfig.screenWidth! * 0.08,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight! * 0.02),
            Image(
              image: ResizeImage(
                AssetImage(imgUrl),
                width: width.toInt(),
                height: height.toInt(),
              ),
              fit: BoxFit.cover,
              width: width,
              height: height,
            ),
            SizedBox(height: SizeConfig.screenHeight! * 0.03),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth! * 0.06),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(SizeConfig.screenWidth! * 0.05),
              ),
              child: Text(
                subTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: SizeConfig.screenWidth! * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
