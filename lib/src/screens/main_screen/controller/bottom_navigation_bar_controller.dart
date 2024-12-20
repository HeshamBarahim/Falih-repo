import 'package:get/get.dart';

import '../../../../generated/l10n.dart';
import '../../curriculum/curriculum_page.dart';
import '../../home/home_page.dart';
import '../../leaderboard/leaderboard_screen.dart';

class BottomNavBarController extends GetxController {
  final Rx<int> selectedIndex = 1.obs;

  final screens = [
    CurriculumPage(),
    HomePage(),
    LeaderBoardScreen(),
  ];
  final screenTitle = [
    S.current.subjects,
    S.current.home,
    S.current.leaderBoard
  ];
}
