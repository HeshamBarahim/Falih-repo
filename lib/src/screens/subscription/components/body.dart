import 'package:flutter/material.dart';

import 'package:falih/src/config/sizes.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        // Plan options
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF532262),
            borderRadius:
                BorderRadius.circular(SizeConfig.screenWidth! * 0.029),
          ),
          padding: EdgeInsets.all(SizeConfig.screenWidth! * 0.048),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Annual",
                    style: TextStyle(
                      fontSize: SizeConfig.screenWidth! * 0.043,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFBF7FC),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth! * 0.015,
                      vertical: SizeConfig.screenHeight! * 0.005,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(
                          SizeConfig.screenWidth! * 0.024),
                    ),
                    child: Text(
                      "Best Value",
                      style: TextStyle(
                        fontSize: SizeConfig.screenWidth! * 0.029,
                        color: Color(0xFFFBF7FC),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.012),
              Text(
                "First 30 days free - Then \$999/Year",
                style: TextStyle(
                  color: Color(0xFFFBF7FC),
                  fontSize: SizeConfig.screenWidth! * 0.035,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: SizeConfig.screenHeight! * 0.024),

        Container(
          decoration: BoxDecoration(
            color: Color(0xFFE4CAEC),
            borderRadius:
                BorderRadius.circular(SizeConfig.screenWidth! * 0.029),
          ),
          padding: EdgeInsets.all(SizeConfig.screenWidth! * 0.048),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Monthly",
                    style: TextStyle(
                      fontSize: SizeConfig.screenWidth! * 0.043,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF743089),
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.012),
                  Text(
                    "First 7 days free - Then \$99/Month",
                    style: TextStyle(
                      color: Color(0xFF743089),
                      fontSize: SizeConfig.screenWidth! * 0.035,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
