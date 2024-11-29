import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:flutter/material.dart';

import 'components/leaderboard_list_section.dart';
import 'components/top_leaderboard_section.dart';

class LeaderBoardScreen extends StatelessWidget {
  static const String sc_route = '/leader-board-screen';

  LeaderBoardScreen({super.key});

  final List<Map<String, dynamic>> usersList = [
    {
      "name": "Hisham",
      "points": 1847,
      "image": "assets/images/yousif.png",
      "rank": 2
    },
    {
      "name": "Yusif",
      "points": 2430,
      "image": "assets/images/yousif.png",
      "rank": 1,
    },
    {
      "name": "Sameer",
      "points": 1674,
      "image": "assets/images/yousif.png",
      "rank": 3
    },
    {
      "name": "Sebastian",
      "points": 1124,
      "image": "assets/images/yousif.png",
      "rank": 4
    },
    {
      "name": "You",
      "points": 875,
      "image": "assets/images/yousif.png",
      "rank": 5
    },
    {
      "name": "Natalie",
      "points": 774,
      "image": "assets/images/yousif.png",
      "rank": 6
    },
    {
      "name": "Serenity",
      "points": 723,
      "image": "assets/images/yousif.png",
      "rank": 7
    },
    {
      "name": "Hannah",
      "points": 559,
      "image": "assets/images/yousif.png",
      "rank": 8
    },
    {
      "name": "Mona",
      "points": 550,
      "image": "assets/images/yousif.png",
      "rank": 9
    },
    {
      "name": "Fatima",
      "points": 490,
      "image": "assets/images/yousif.png",
      "rank": 10
    },
    {
      "name": "Lena",
      "points": 320,
      "image": "assets/images/yousif.png",
      "rank": 11
    },
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.backgroundImageOfAuth),
                fit: BoxFit.cover,
                opacity: .2,
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth! * 0.03),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBF7FC),
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 50,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  // child: ListTile(
                  //   leading: Icon(
                  //     Icons.notifications_none,
                  //     color: Color(0xFF743089),
                  //     size: SizeConfig.screenWidth! * 0.11,
                  //   ),
                  //   titleAlignment: ListTileTitleAlignment.top,
                  //   title: Center(
                  //     child: Text(
                  //       'Leaderboard',
                  //       style: TextStyle(
                  //         fontSize: SizeConfig.screenWidth! * 0.065,
                  //         fontWeight: FontWeight.bold,
                  //         color: Color(0xFF743089),
                  //       ),
                  //     ),
                  //   ),
                  //   trailing: Icon(
                  //     Icons.grid_view_rounded,
                  //     color: Color(0xFF743089),
                  //     size: SizeConfig.screenWidth! * 0.11,
                  //   ),
                  // ),
                ),
                TopLeaderboardSection(
                  topUsers: usersList.where((e) => e['rank'] < 4).toList(),
                ),
                Container(
                  height: SizeConfig.screenHeight! * 0.38,
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth! * 0.04,
                      vertical: SizeConfig.screenHeight! * 0.015),
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth! * 0.04,
                      vertical: SizeConfig.screenHeight! * 0.015),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBF7FC),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ListView(
                    children: usersList
                        .where((e) => e['rank'] > 3)
                        .map((e) => LeaderboardListSection(
                            image: e['image'],
                            name: e['name'],
                            points: e['points']))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: GetBuilder<FloatingNavBarController>(
      //   init: FloatingNavBarController(),
      //   builder: (controller) {
      //     return Padding(
      //       padding: EdgeInsets.only(bottom: SizeConfig.screenHeight! * 0.03),
      //       child: Container(
      //         margin: EdgeInsets.symmetric(
      //             horizontal: SizeConfig.screenWidth! * 0.18),
      //         decoration: BoxDecoration(
      //           color: Colors.white,
      //           borderRadius: BorderRadius.circular(30.0),
      //           boxShadow: [
      //             BoxShadow(
      //               color: Colors.black26,
      //               blurRadius: 10,
      //               offset: Offset(3, 2),
      //             ),
      //           ],
      //         ),
      //         child: BottomNavigationBar(
      //           currentIndex: controller.selectedIndex,
      //           onTap: (val) {
      //             controller.changeIndex(val);
      //           },
      //           backgroundColor: Color(0xFFFBF7FC),
      //           elevation: 0,
      //           selectedLabelStyle: TextStyle(
      //             fontSize: SizeConfig.screenWidth! * 0.032,
      //             color: Color(0xFF743089),
      //           ),
      //           showUnselectedLabels: false,
      //           selectedIconTheme: IconThemeData(
      //             color: Color(0xFF743089),
      //             size: SizeConfig.screenWidth! * 0.08,
      //           ),
      //           unselectedIconTheme: IconThemeData(
      //             color: Color(0xFFBBA3C2),
      //             size: SizeConfig.screenWidth! * 0.07,
      //           ),
      //           items: [
      //             BottomNavigationBarItem(
      //               icon: Icon(Icons.search),
      //               label: 'Search',
      //             ),
      //             BottomNavigationBarItem(
      //               icon: Icon(Icons.home),
      //               label: 'Home',
      //             ),
      //             BottomNavigationBarItem(
      //               icon: Icon(Icons.leaderboard_outlined),
      //               label: 'LeaderBoard',
      //             ),
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      // )
    );
  }
}
