import 'package:falih/src/screens/run_exam/widgets_run_exam/choices.dart';
import 'package:flutter/material.dart';

class ColumnOfChoices extends StatelessWidget {
  const ColumnOfChoices({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the choices data
    final List<Map<String, String>> choicesData = [
      {'choiceNumber': 'A', 'choiceText': '0.50'},
      {'choiceNumber': 'B', 'choiceText': '0.99'},
      {'choiceNumber': 'C', 'choiceText': '0.20'},
      {'choiceNumber': 'D', 'choiceText': '0.454'},
    ];

    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: ListView.builder(
        shrinkWrap: true, // Allows ListView to wrap its content
        itemCount: choicesData.length,
        itemBuilder: (context, index) {
          return Choices(
            choiceNumber: choicesData[index]['choiceNumber']!,
            choiceText: choicesData[index]['choiceText']!,
            index: index,
          );
        },
      ),
    );
  }
}
