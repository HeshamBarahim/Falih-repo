import 'package:flutter/material.dart';

import 'package:falih/src/config/const.dart';
import 'package:falih/src/config/sizes.dart';
import 'components/footer.dart';
import 'components/body.dart';
import 'components/header.dart';

class SubscriptionScreen extends StatelessWidget {
  static const String sc_route = '/subscription-screen';
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: secondaryBackgroundColor_2),
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.screenWidth! * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Color(0xFFFBF7FC),
                  size: SizeConfig.screenWidth! * 0.085,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              SizedBox(height: SizeConfig.screenHeight! * 0.018),

              // Header
              Header(),

              SizedBox(height: SizeConfig.screenHeight! * 0.059),

              //Body
              // Plan options
              Body(),
              Spacer(),

              // Checkout Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // was primary change it to primary
                    backgroundColor: const Color(0xFF743089),
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth! * 0.243,
                      vertical: SizeConfig.screenHeight! * 0.024,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          SizeConfig.screenWidth! * 0.029),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Checkout",
                    style: TextStyle(
                      fontSize: SizeConfig.screenWidth! * 0.043,
                      color: Color(0xFFFBF7FC),
                    ),
                  ),
                ),
              ),

              SizedBox(height: SizeConfig.screenHeight! * 0.024),

              // Footer
              // Terms and Privacy
              Footer(),
              SizedBox(height: SizeConfig.screenHeight! * 0.024),
            ],
          ),
        ),
      ),
    );
  }
}
