import 'package:flutter/material.dart';

class BoardingCarousel extends StatelessWidget {
  const BoardingCarousel({
    super.key,
    required this.fColor,
    required this.sColor,
    required this.tColor,
  });

  final Color fColor;
  final Color sColor;
  final Color tColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 15),
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: fColor),
        ),
        Container(
          margin: const EdgeInsets.only(right: 15),
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: sColor),
        ),
        Container(
          margin: const EdgeInsets.only(right: 15),
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: tColor),
        ),
      ],
    );
  }
}
