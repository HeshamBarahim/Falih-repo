import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import '../repository/user_repository/user_repository.dart';

class LeaderboardController extends GetxController {
  int selectedIndex = 2;
  var isLoading = true.obs;
  RxList<UserModel> usersList = <UserModel>[].obs;
  final _db = FirebaseFirestore.instance;
  Map<String, int> userPoints = <String, int>{}.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    usersList.value = await UserRepository.instance.allUsers();
    userPoints = await aggregatePointsByUser();

    usersList.sort((a, b) {
      int pointsA = userPoints[a.id] ?? 0;
      int pointsB = userPoints[b.id] ?? 0;
      return pointsB.compareTo(pointsA); // Sort in descending order
    });
    isLoading.value = false;
  }

  void changeIndex(int index) {
    selectedIndex = index;
    update();
  }

  DateTime getStartOfMonth() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, 1);
  }

  DateTime getEndOfMonth() {
    final now = DateTime.now();
    return DateTime(now.year, now.month + 1, 0, 23, 59, 59);
  }

  Future<List<Map<String, dynamic>>> fetchExamsForCurrentMonth() async {
    final List<String> userIds =
        usersList.value.map((doc) => doc.id).cast<String>().toList();
    final List<Map<String, dynamic>> exams = [];

    final DateTime startOfMonth =
        DateTime(DateTime.now().year, DateTime.now().month, 1);
    final DateTime endOfMonth =
        DateTime(DateTime.now().year, DateTime.now().month + 1, 0, 23, 59, 59);

    for (final userId in userIds!) {
      final QuerySnapshot userExamsSnapshot = await _db
          .collection('exams')
          .doc(userId)
          .collection('userExams')
          .where('date', isGreaterThanOrEqualTo: startOfMonth)
          .where('date', isLessThanOrEqualTo: endOfMonth)
          .get();

      // Add userId along with each exam data
      exams.addAll(userExamsSnapshot.docs.map((doc) {
        final examData = doc.data() as Map<String, dynamic>;
        examData['userId'] = userId; // Add userId to the exam data
        return examData; // Return the modified map
      }));
    }

    return exams;
  }

  Future<Map<String, int>> aggregatePointsByUser() async {
    final List<Map<String, dynamic>> exams = await fetchExamsForCurrentMonth();
    final Map<String, int> userPoints = {};

    for (var exam in exams) {
      final String userId = exam[
          'userId']; // Add `userId` in your `userExams` document data if not present.
      final int pointsEarned = exam['points'];

      userPoints[userId] = (userPoints[userId] ?? 0) + pointsEarned;
    }
    print(userPoints);
    return userPoints;
  }
}

// final List<Map<String, dynamic>> usersList = [
//   {
//     "name": "Hisham",
//     "points": 1847,
//     "image": "assets/images/yousif.png",
//     "rank": 2
//   },
//   {
//     "name": "Yusif",
//     "points": 2430,
//     "image": "assets/images/yousif.png",
//     "rank": 1,
//   },
//   {
//     "name": "Sameer",
//     "points": 1674,
//     "image": "assets/images/yousif.png",
//     "rank": 3
//   },
//   {
//     "name": "Sebastian",
//     "points": 1124,
//     "image": "assets/images/yousif.png",
//     "rank": 4
//   },
//   {
//     "name": "You",
//     "points": 875,
//     "image": "assets/images/yousif.png",
//     "rank": 5
//   },
//   {
//     "name": "Natalie",
//     "points": 774,
//     "image": "assets/images/yousif.png",
//     "rank": 6
//   },
//   {
//     "name": "Serenity",
//     "points": 723,
//     "image": "assets/images/yousif.png",
//     "rank": 7
//   },
//   {
//     "name": "Hannah",
//     "points": 559,
//     "image": "assets/images/yousif.png",
//     "rank": 8
//   },
//   {
//     "name": "Mona",
//     "points": 550,
//     "image": "assets/images/yousif.png",
//     "rank": 9
//   },
//   {
//     "name": "Fatima",
//     "points": 490,
//     "image": "assets/images/yousif.png",
//     "rank": 10
//   },
//   {
//     "name": "Lena",
//     "points": 320,
//     "image": "assets/images/yousif.png",
//     "rank": 11
//   },
// ];
