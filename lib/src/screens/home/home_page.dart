import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/home/widgets_home/custom_progress_bar.dart';
import 'package:falih/src/screens/home/widgets_home/custom_sub_header.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  late double precentage = 0.50;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  first heading text
            Container(
              child: Text(
                S.of(context).first_header_home,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
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
            // line
            Container(
              height: 1.0,
              color: AppColors.borderColor,
              margin: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5),
            ),
          ],
        ),
      ),
    );
  }
}
