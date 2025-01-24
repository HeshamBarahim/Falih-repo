import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';

import '../../../generated/l10n.dart';

class MdDialogs extends StatelessWidget {
  final String mdFileName;

  MdDialogs({
    required this.mdFileName,
    super.key,
  }) : assert(mdFileName.contains('.md'),
            'The file must contain the .md extension');

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
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
                return Directionality(
                  textDirection: Get.locale?.languageCode == "ar"
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: Markdown(
                    data: snapshot.data ?? '',
                    styleSheet: MarkdownStyleSheet(
                      h1Align: WrapAlignment.center,
                      h1: const TextStyle(
                          fontSize: 22.0, // Adjust the font size if needed
                          color: AppColors.darkMainColor,
                          fontWeight:
                              FontWeight.bold // Optional: Change the text color
                          ),
                      h2: const TextStyle(
                          fontSize: 20.0, // Adjust the font size if needed
                          color: AppColors.mainColor,
                          fontWeight:
                              FontWeight.bold // Optional: Change the text color
                          ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GradientButton(
              text: S.of(context).close,
              height: SizeConfig.screenHeight! * 0.07,
              width: double.infinity,
              onClick: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
