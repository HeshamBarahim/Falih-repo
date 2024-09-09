import 'package:falih/generated/l10n.dart';
import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Row(
            children: [
              const Icon(
                Icons.stacked_line_chart,
                color: Color(0xFFD39646),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                S.of(context).statistics,
                style: const TextStyle(
                    color: Color(0xFFD39646), fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Row(
            children: [
              const Icon(Icons.app_shortcut_sharp, color: Color(0xFFD39646)),
              const SizedBox(
                width: 5,
              ),
              Text(
                S.of(context).chapters,
                style: const TextStyle(
                    color: Color(0xFFD39646), fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Row(
            children: [
              const Icon(
                Icons.bookmarks_sharp,
                color: Color(0xFFD39646),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                S.of(context).exams,
                style: const TextStyle(
                    color: Color(0xFFD39646), fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )
      ],
    );
  }
}
