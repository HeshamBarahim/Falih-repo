import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_button.dart';
import 'package:falih/src/screens/run_exam/widgets_run_exam/bottom_sheet.dart';
import 'package:falih/src/screens/run_exam/widgets_run_exam/column_of_choices.dart';
import 'package:falih/src/screens/run_exam/widgets_run_exam/question_box.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class RunExam extends StatelessWidget {
  const RunExam({super.key});

  @override
  Widget build(BuildContext context) {
    // take color and subject name from subject page
    final LinearGradient color = Get.arguments['color'];
    // final String name = Get.arguments['name'];

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(gradient: color),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              // Question box
              const QuestionBox(),
              const SizedBox(
                height: 30,
              ),
              const ColumnOfChoices(),
              const SizedBox(
                height: 40,
              ),

              // Ai button
              Center(
                child: GradientButton(
                  text: 'Ai',
                  height: 50,
                  width: 100,
                  onClick: () => showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) => const BottomSheetWidget()),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // confirm button
              GradientButton(
                text: S.of(context).confirm,
                height: 50,
                width: double.infinity,
                onClick: () {},
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
