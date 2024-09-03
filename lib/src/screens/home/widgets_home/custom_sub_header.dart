import 'package:falih/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:falih/src/config/themes.dart';

class CustomSubHeader extends StatelessWidget {
  const CustomSubHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: RichText(
      text: TextSpan(children: [
        TextSpan(
            text: S.of(context).part_one_subHeader,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500)),
        TextSpan(
            text: S.of(context).changing_subHeader,
            style: const TextStyle(
                color: AppColors.subHeaderNotTaken,
                fontWeight: FontWeight.w600)),
        TextSpan(
            text: S.of(context).part_two_subHeader,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500))
      ]),
    ));
  }
}
