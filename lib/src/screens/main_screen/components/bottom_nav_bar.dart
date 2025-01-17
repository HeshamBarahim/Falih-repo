import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../config/sizes.dart';
import '../../../config/themes.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int?)? onDestinationSelected;

  const BottomNavBar(
      {super.key,
      required this.selectedIndex,
      required this.onDestinationSelected});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.moreLightenMainColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.darkMainColor,
            blurRadius: 15,
            offset: Offset(5, 9),
          ),
        ],
        border: Border(
          top: BorderSide(
            color: AppColors.mainColor, // Border color
            width: 0.5, // Border width
          ),
        ),
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: AppColors.choicesColor,
          backgroundColor: AppColors.moreLightenMainColor,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return const TextStyle(
                  fontSize: 14, // Font size for selected labels
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainColor, // Selected label color
                );
              }
              return const TextStyle(
                fontSize: 0, // Font size for unselected labels
                color: Color(0xFFD2A8DF), // Unselected label color
              );
            },
          ),
        ),
        child: NavigationBar(
          elevation: 0,
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          destinations: [
            NavigationDestination(
              selectedIcon: Icon(
                Icons.menu_book,
                color: AppColors.mainColor,
                size: SizeConfig.screenHeight! * 0.04,
              ),
              icon: Icon(
                Icons.menu_book_outlined,
                color: const Color(0xFFD2A8DF),
                size: SizeConfig.screenHeight! * 0.04,
              ),
              label: S.of(context).subjects,
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.home,
                color: AppColors.mainColor,
                size: SizeConfig.screenHeight! * 0.04,
              ),
              icon: Icon(
                Icons.home,
                color: const Color(0xFFD2A8DF),
                size: SizeConfig.screenHeight! * 0.04,
              ),
              label: S.of(context).home,
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.leaderboard_outlined,
                color: AppColors.mainColor,
                size: SizeConfig.screenHeight! * 0.04,
              ),
              icon: Icon(
                Icons.leaderboard_outlined,
                color: const Color(0xFFD2A8DF),
                size: SizeConfig.screenHeight! * 0.04,
              ),
              label: S.of(context).leaderBoard,
            ),
          ],
        ),
      ),
    );
  }
}
