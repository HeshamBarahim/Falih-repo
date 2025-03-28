import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/text_formatter_controller.dart';
import 'package:falih/src/screens/exam/exam_widgets/ai_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/images.dart';
import '../../config/sizes.dart';
import '../../constants/functions.dart';
import '../../controller/exam_controller.dart';
import '../../controller/subjects_controller.dart';

class ExamScreen extends StatelessWidget {
  ExamScreen({super.key});

  final TextFormatterController textController =
      Get.put(TextFormatterController());

  @override
  Widget build(BuildContext context) {
    final ExamController controller = Get.find<ExamController>();
    SizeConfig().init(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (!didPop) {
          final isRTL = Get.locale?.languageCode == "ar"
              ? TextAlign.right
              : TextAlign.left;

          bool confirmExit = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                S.current.exit_exam,
                textAlign: isRTL,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Get.isDarkMode
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).primaryColor,
                    ),
              ),
              content: Text(
                S.current.exit_exam_warning,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Get.isDarkMode
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).primaryColor,
                    ),
                textAlign: isRTL, // Align button text
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  // Stay in exam
                  child: Text(
                    S.current.cancel,
                    textAlign: isRTL,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Get.isDarkMode
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).primaryColor,
                        ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true); // Allow exit
                    Get.back(); // Pop the exam screen
                  },
                  child: Text(
                    S.current.exit, textAlign: isRTL, // Align button text
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Get.isDarkMode
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).primaryColor,
                        ),
                  ),
                ),
              ],
            ),
          );

          if (confirmExit == true) {
            final subjectsController = Get.find<SubjectsController>();
            subjectsController.changeSelectedIndex(0);
            subjectsController.changeSelectedSectionIndex(0);
            controller.resetExam();
            Get.back(); // Navigate back only if confirmed
          }
        }
      },
      child: Scaffold(
        body: Obx(() {
          if (controller.questions.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final question = controller.questions[controller.questionIndex.value];
          final questionNumber = controller.questionIndex.value;
          final selectedAnswer =
              controller.selectedAnswers[controller.questionIndex.value];

          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
                    SizedBox(height: SizeConfig.screenHeight! * 0.12),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: SizeConfig.screenHeight! * 0.28,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.mainColor, width: 2),
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.darkMainColor.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 12,
                                offset: const Offset(
                                    0, 10), // Shadow position (x, y)
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment:
                                  isArabic(question.questionText)
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.green,
                                      ),
                                      width: SizeConfig.screenWidth! * 0.12,
                                      child: Center(
                                        child: Text(
                                          '${controller.trueAnswers.value}',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.red,
                                      ),
                                      width: SizeConfig.screenWidth! * 0.12,
                                      child: Center(
                                        child: Text(
                                          '${controller.falseAnswers.value}',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: SizeConfig.screenHeight! * 0.01),
                                Center(
                                  child: Text(
                                    "${S.of(context).question} ${questionNumber + 1}/${controller.questions.length}",
                                    style: const TextStyle(
                                        color: AppColors.warningColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                    height: SizeConfig.screenHeight! * 0.03),
                                Directionality(
                                    textDirection:
                                        isArabic(question.questionText)
                                            ? TextDirection.rtl
                                            : TextDirection.ltr,
                                    child: textController.formatText(
                                        question.questionText,
                                        lightModeColor: Theme.of(Get.context!)
                                            .colorScheme
                                            .secondary)),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Transform.translate(
                            offset: Offset(0, -SizeConfig.screenHeight! * 0.05),
                            child: Container(
                              width: SizeConfig.screenWidth! * 0.18,
                              height: SizeConfig.screenWidth! * 0.18,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.darkMainColor, width: 3),
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColors.choicesColor),
                              child: Center(
                                child: Obx(
                                  () => Text(
                                      controller.formatTime(
                                          controller.currentTime.value),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          )),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * 0.02),
                    Column(
                      children: [
                        ...question.options.asMap().entries.map((entry) {
                          int idx = entry.key;
                          String option = entry.value;
                          if (option == "") {
                            return Container();
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                controller.selectAnswer(idx);
                              },
                              child: Container(
                                height: SizeConfig.screenHeight! * 0.07,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: selectedAnswer == idx
                                      ? AppColors.darkMainColor
                                      : AppColors.mainColor.withOpacity(0.60),
                                  border: Border.all(
                                    color: selectedAnswer != null &&
                                            question.correctAnswerIndex == idx
                                        ? AppColors
                                            .successColor // Border color when selected
                                        : selectedAnswer == idx
                                            ? AppColors.errorColor
                                            : Colors.transparent,
                                    // Border color when not selected
                                    width: 2, // Adjust border width as needed
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      Center(
                                        child: Text(
                                          (idx + 1).toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                color: Get.isDarkMode
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .secondary
                                                    : Theme.of(context)
                                                        .primaryColor,
                                              ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),

                                      textController.formatText(
                                        option.toLowerCase().trim() == "true" ||
                                                option.toLowerCase().trim() ==
                                                    "false"
                                            ? Get.locale?.languageCode == "ar"
                                                ? (option
                                                            .toLowerCase()
                                                            .trim() ==
                                                        "true"
                                                    ? "صح"
                                                    : "خطأ")
                                                : (option
                                                            .toLowerCase()
                                                            .trim() ==
                                                        "true"
                                                    ? "True"
                                                    : "False")
                                            : option,
                                      ),

                                      const Spacer(),
                                      selectedAnswer != null &&
                                              question.correctAnswerIndex == idx
                                          ? const Icon(
                                              Icons.check_circle, // True widget
                                              color: AppColors.successColor,
                                              // Green color for correct answer
                                              size: 24,
                                            )
                                          : selectedAnswer == idx
                                              ? const Icon(
                                                  Icons.cancel, // X widget
                                                  color: Colors.red,
                                                  // Red color for incorrect answer
                                                  size: 24,
                                                )
                                              : Container()
                                      // Add space between the text and the widget
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.moveToAnotherQuestion(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Theme.of(context).colorScheme.primary),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.navigate_before,
                              ),
                              Text(
                                S.of(context).continueText,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.selectedAnswers[
                                    controller.questionIndex.value] !=
                                null
                            ? showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) => AIBottomSheet(),
                              )
                            : null;
                        controller.generateResponse(question.questionText);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: SizedBox(
                          height: 64,
                          width: 64,
                          child: Image.asset(
                            Images.falih,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // Widget buildQuestionText(String question) {
  //   // Detect if the question contains mathematical symbols
  //   bool containsMath = question.contains(RegExp(r'[/√^]'));
  //   return containsMath
  //       ? buildMathQuestion(question)
  //       : Expanded(
  //           child: AutoSizeText(
  //             question,
  //             style: Theme.of(Get.context!).textTheme.bodyMedium,
  //             minFontSize: 12, // Minimum size to shrink to
  //           ),
  //         );
  // }

  // String formatFractions(String input) {
  //   // First, replace fractions (e.g., 9/3) with LaTeX style \frac{numerator}{denominator}
  //   input = input.replaceAllMapped(RegExp(r'(\d+)/(\d+)'), (match) {
  //     return r"\frac{" + match.group(1)! + "}{" + match.group(2)! + "}";
  //   });

  //   input = input.replaceAllMapped(RegExp(r'(-?[\dπ]+)\/([\dπ]+)'), (match) {
  //     return r"\frac{" + match.group(1)! + "}{" + match.group(2)! + "}";
  //   });

  //   input = input.replaceAllMapped(RegExp(r'\(([^)]+)\)/(\d+)'), (match) {
  //     return r"\frac{" + match.group(1)! + "}{" + match.group(2)! + "}";
  //   });

  //   while (input.indexOf('/') > 0) {
  //     int divisionIndex = input.indexOf('/');
  //     divisionIndex = divisionIndex - 1;
  //     input = input.replaceFirst("/", "");
  //     // input = r"\text {" +
  //     input.substring(0, divisionIndex) +
  //         r"} \frac " +
  //         input.substring(divisionIndex, divisionIndex + 2) +
  //         r"\text {" +
  //         input.substring(divisionIndex + 2);
  //   }

  //   while (input.indexOf('√') > 0) {
  //     int rootIndex = input.indexOf('√');
  //     rootIndex = rootIndex - 1;
  //     input = input.replaceFirst("√", r" \sqrt");
  //   }

  //   // Now handle complex numbers like "9-3i" and "1+3i"
  //   // input = input.replaceAllMapped(RegExp(r'([0-9\-+]+)(i)'), (match) {
  //   //   return match.group(1)! + r"\cdot i"; // Convert "9-3i" into "9-3\cdot i"
  //   // });

  //   // Optionally, you can format the entire complex number expression as a fraction (if applicable)
  //   // Example: if the input is a complex number expression in the form of (a + bi)/(c + di)
  //   input = input.replaceAllMapped(RegExp(r'\(([^)]+)\)/\(([^)]+)\)'), (match) {
  //     return r"\frac{" + match.group(1)! + "}{" + match.group(2)! + "}";
  //   });

  //   return input;
  // }

  // Widget buildMathQuestion(String question) {
  //   // Replace root by latex root
  //   // print(question);
  //   question = formatFractions(question);
  //   question = question.replaceAll(' ', r'\,');
  //   // print("------------");
  //   // print(question);

  //   final maxWidth = SizeConfig.screenWidth! - 10;
  //   final processedEquation = insertAllowBreakByCharCount(question, maxWidth);
  //   // print(processedEquation);
  //   final longEq = Math.tex(
  //     processedEquation,
  //     mathStyle: MathStyle.display,
  //     textStyle: const TextStyle(fontSize: 18, color: AppColors.mainColor),
  //   );

  //   return Wrap(
  //     runSpacing: 15,
  //     children: longEq.texBreak().parts,
  //   );
  // }

  int estimateCharsPerLine(String sample, double maxWidth) {
    // Use a sample string that represents an average-case width.
    const style = TextStyle(fontSize: 20, color: Colors.black);
    final textPainter = TextPainter(
      text: TextSpan(text: sample, style: style),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    // Calculate average character width.
    final avgCharWidth = textPainter.width / sample.length;
    return (maxWidth / avgCharWidth).floor();
  }

  String insertAllowBreakByCharCount(String input, double maxWidth) {
    final maxChars = estimateCharsPerLine(input, maxWidth);
    StringBuffer buffer = StringBuffer();

    int count = 0;
    int lastSpaceIndex =
        -1; // Track the index of the last space for a safe break.
    bool inLaTeXCommand =
        false; // To track whether we're inside a LaTeX command.

    for (int i = 0; i < input.length; i++) {
      final char = input[i];

      // If we detect a LaTeX command, we skip over it without breaking.
      if (char == '\\' && i + 1 < input.length && input[i + 1] == 'f') {
        inLaTeXCommand = true; // Start of a LaTeX command (e.g., \frac, \sqrt)
      } else if (inLaTeXCommand && char == '}') {
        inLaTeXCommand = false; // End of the LaTeX command
      }

      // Only process non-LaTeX characters for word wrapping.
      if (!inLaTeXCommand) {
        buffer.write(char);
        count++;

        // If the current character is a space, record its index (in the output).
        if (char == ' ') {
          lastSpaceIndex = buffer.length;
        }

        // When we have reached the estimated maximum...
        if (count >= maxChars) {
          // If we have a recent space, insert \allowbreak there.
          if (lastSpaceIndex != -1) {
            String currentLine = buffer.toString();
            currentLine = currentLine.replaceRange(
                lastSpaceIndex - 1, lastSpaceIndex, " \\allowbreak ");
            buffer = StringBuffer(currentLine);
            count = 0;
            lastSpaceIndex = -1;
          } else {
            // If no space found, insert \allowbreak immediately.
            buffer.write(" \\allowbreak ");
            count = 0;
          }
        }
      } else {
        // If inside LaTeX command, just append the character.
        buffer.write(char);
      }
    }

    return buffer.toString();
  }
}
