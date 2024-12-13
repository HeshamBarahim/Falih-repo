import 'package:flutter/material.dart';

import '../../../config/sizes.dart';

class OnBoardingViews extends StatelessWidget {
  final LinearGradient linearGradientColor;
  final String imgUrl;
  final String title;
  final String subTitle;

  const OnBoardingViews(
      {super.key,
      required this.linearGradientColor,
      required this.imgUrl,
      required this.title,
      required this.subTitle});

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
            Image.asset(
              imgUrl,
              fit: BoxFit.cover,
              width: SizeConfig.screenWidth!,
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
