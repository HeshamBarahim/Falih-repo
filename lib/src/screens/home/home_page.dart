import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/home/widgets_home/custom_carousel.dart';
import 'package:falih/src/screens/home/widgets_home/custom_progress_bar.dart';
import 'package:falih/src/screens/home/widgets_home/custom_sub_header.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  // test precentage of progress bar
  late double precentage = 0.50;
  int myindex = 0;

  // test the list
  final images = [
    Image.asset('assets/images/test.png'),
    Image.asset('assets/images/test.png'),
    Image.asset('assets/images/test.png'),
  ];
  List<Widget> widgetList = const [
    HomePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  first heading text
            Text(
              S.of(context).first_header_home,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // sub header
            const CustomSubHeader(),
            const SizedBox(
              height: 5,
            ),

            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: Image.asset(
                    Images.silverMedal,
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.contain,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Text(S.of(context).score),
                    ),
                    // progress bar of home page
                    CustomProgressBar(
                        width: 250, height: 20, progress: precentage),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(
                        S.of(context).name_league,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            //  just line
            Container(
              height: 1.0,
              color: AppColors.borderColor,
              margin: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5),
            ),
            const SizedBox(
              height: 10,
            ),
            // image ane indcator slider
            CustomCarousel(
              images: images,
            ),
            const SizedBox(
              height: 10,
            ),
            // history side
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).history_heading,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const Icon(
                  Icons.info_outline_rounded,
                  color: Color(0XFFD42A2A),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // last part of home page ,,, before he taken any exam
            Center(
              child: Text(
                S.of(context).not_taken_exams_home_page,
                style: const TextStyle(
                    color: AppColors.shadowColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
            )
          ],
        ),
      ),
    );
  }
}
