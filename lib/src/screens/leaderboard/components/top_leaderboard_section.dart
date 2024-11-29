import 'package:flutter/material.dart';

class TopLeaderboardSection extends StatelessWidget {
  const TopLeaderboardSection({
    super.key,
    required this.topUsers,
  });

  final List<Map<String, dynamic>> topUsers;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    Map<String, dynamic> highestUser = topUsers.reduce(
        (current, next) => current['points'] > next['points'] ? current : next);

    return Container(
      height: screenHeight * 0.35,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.085),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: topUsers.map((user) {
          bool isMiddleUser = user['rank'] == 1;
          bool isSecondUser = user['rank'] == 2;
          bool isThirdUser = user['rank'] == 3;
          bool hasCrown = user == highestUser;

          return Expanded(
            flex: isMiddleUser ? 5 : 4,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  bottom: screenHeight * 0.012,
                  child: Container(
                    height: isMiddleUser
                        ? screenHeight * 0.19
                        : screenHeight * 0.14,
                    width: screenWidth * 0.29,
                    padding: EdgeInsets.only(
                        top: isMiddleUser
                            ? screenHeight * 0.071
                            : screenHeight * 0.051),
                    decoration: BoxDecoration(
                      color: isMiddleUser
                          ? const Color(0xFF743089)
                          : const Color.fromARGB(255, 237, 237, 237),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(isMiddleUser
                            ? screenWidth * 0.073
                            : screenWidth * 0.06),
                        topRight: Radius.circular(isMiddleUser
                            ? screenWidth * 0.073
                            : screenWidth * 0.06),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          offset: Offset(0, screenHeight * 0.005),
                          blurRadius: screenHeight * 0.01,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          user['name'],
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.bold,
                            color: isMiddleUser
                                ? Colors.white
                                : const Color(0xFF743089),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.003),
                        Text(
                          '${user['points']}p',
                          style: TextStyle(
                            fontSize: screenWidth * 0.037,
                            color: Colors.green,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      top: isMiddleUser
                          ? screenHeight * 0.089
                          : screenHeight * 0.14,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF3CD797),
                            width: screenWidth * 0.01,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: isMiddleUser
                              ? screenWidth * 0.1
                              : screenWidth * 0.085,
                          backgroundImage: AssetImage(user['image']),
                          onBackgroundImageError: (_, __) =>
                              const AssetImage('assets/images/placeholder.png'),
                        ),
                      ),
                    ),
                    if (hasCrown)
                      Positioned(
                        top: screenHeight * 0.053,
                        child: Image.asset(
                          'assets/images/crown_icon.png',
                          width: screenWidth * 0.085,
                        ),
                      ),
                    if (isMiddleUser || isSecondUser || isThirdUser)
                      Positioned(
                        top: isMiddleUser
                            ? screenHeight * 0.18
                            : screenHeight * 0.22,
                        child: Transform.rotate(
                          angle: 38.5,
                          child: Container(
                            height: screenWidth * 0.048,
                            width: screenWidth * 0.048,
                            decoration: BoxDecoration(
                              color: const Color(0xFF3CD797),
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.012),
                            ),
                            child: Transform.rotate(
                              angle: 49.5,
                              child: Center(
                                child: Text(
                                  '${user['rank']}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.032,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
