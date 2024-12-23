import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';

class MdDialogs extends StatelessWidget {
  final double radius;
  final String mdFileName;
  final String buttonText;

  MdDialogs({
    this.radius = 8,
    required this.mdFileName,
    required this.buttonText,
    super.key,
  }) : assert(mdFileName.contains('.md'),
            'The file must contain the .md extension');

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: rootBundle.loadString('assets/md_files/$mdFileName'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error loading content'));
                }
                return Markdown(data: snapshot.data ?? '');
              },
            ),
          ),
          GradientButton(
            text: buttonText,
            height: SizeConfig.screenHeight! * 0.07,
            width: SizeConfig.screenWidth! * 0.60,
            onClick: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
