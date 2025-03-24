import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A widget to display a fraction given as a string "numerator/denominator".
/// It optionally displays a horizontal line between the numerator and denominator.
class FractionText extends StatelessWidget {
  final String fraction;
  final double fontSize;
  final Color color;
  final double lineWidth;
  final bool showLine;

  const FractionText({
    Key? key,
    required this.fraction,
    this.fontSize = 14,
    this.color = Colors.black,
    this.lineWidth = 20,
    this.showLine = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final parts = fraction.split('/');
    if (parts.length != 2) {
      return Text(fraction,
          style: TextStyle(
            fontSize: fontSize,
          ));
    }

    final numerator = parts[0].trim();
    final denominator = parts[1].trim();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          numerator,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
          ),
        ),
        if (showLine)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 2),
            height: 1,
            width: lineWidth,
            color: Theme.of(context).colorScheme.secondary,
          ),
        Text(
          denominator,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}

/// Controller to format text with special markers into rich text.
/// It detects markers for superscript/subscript as well as fractions.
/// This version uses '#' markers for fractions, with an optional 'n' prefix to indicate no line.
class TextFormatterController extends GetxController {
  Text formatText(String text) {
    List<InlineSpan> spans = [];

    // Regex remains the same
    RegExp regex =
        RegExp(r'((\^|~)([a-zA-Z0-9\u0621-\u064A\+\-\/]+))|(#(n?)([^#]+)#)');

    int lastIndex = 0;
    Iterable<RegExpMatch> matches = regex.allMatches(text);

    for (final match in matches) {
      // Add normal text before the match.
      if (match.start > lastIndex) {
        spans.add(TextSpan(
          text: text.substring(lastIndex, match.start),
          style: Theme.of(Get.context!)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Theme.of(Get.context!).colorScheme.secondary),
        ));
      }

      // Handle superscript/subscript.
      if (match.group(2) != null && match.group(3) != null) {
        String symbol = match.group(2)!; // '^' or '~'
        String characters = match.group(3)!;
        final Offset offset =
            symbol == '^' ? const Offset(0, -10) : const Offset(0, 10);

        spans.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: Transform.translate(
              offset: offset,
              child: Text(
                characters,
                style: Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(Get.context!).colorScheme.secondary),
              ),
            ),
          ),
        );
      }
      // Handle fraction markers.
      else if (match.group(4) != null &&
          match.group(5) != null &&
          match.group(6) != null) {
        String prefix = match.group(5)!; // either '' or 'n'
        String fractionCode = match.group(6)!;
        bool showLine = prefix != 'n';

        spans.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: FractionText(
              fraction: fractionCode,
              fontSize: 14,
              lineWidth: 40,
              showLine: showLine,
            ),
          ),
        );
      }

      lastIndex = match.end;
    }

    // Append any remaining text.
    if (lastIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastIndex),
        style: Theme.of(Get.context!)
            .textTheme
            .bodyLarge
            ?.copyWith(color: Theme.of(Get.context!).colorScheme.secondary),
      ));
    }

    return Text.rich(
      TextSpan(
        children: spans,
        style: Theme.of(Get.context!)
            .textTheme
            .bodyLarge
            ?.copyWith(color: Theme.of(Get.context!).colorScheme.secondary),
      ),
    );
  }
}
