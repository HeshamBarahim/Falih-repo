import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import '../repository/user_repository/user_repository.dart';
import 'home_controller.dart';

class LeaderboardController extends GetxController {
  int selectedIndex = 2;
  var isLoading = true.obs;
  RxList<UserModel> usersList = <UserModel>[].obs;
  final _db = FirebaseFirestore.instance;
  Map<String, int> userPoints = <String, int>{}.obs;
  Map<String, String> topUsersProfile = <String, String>{}.obs;

  final HomeController controller = Get.put(HomeController());
  final UserController userController = Get.put(UserController());

  @override
  Future<void> onInit() async {
    await fetchAllUsersData();
    fetchUserPointsAndRank();
    super.onInit();
  }

  Future<void> fetchAllUsersData() async {
    controller.isLoading.value = true;
    usersList.value = await UserRepository.instance.allUsers();
    userPoints = await aggregatePointsByUser();

    usersList.sort((a, b) {
      int pointsA = userPoints[a.id] ?? 0;
      int pointsB = userPoints[b.id] ?? 0;
      return pointsB.compareTo(pointsA); // Sort in descending order
    });
  }

  void fetchUserPointsAndRank() {
    controller.rank.value = (usersList
            .indexWhere((user) => user.id == userController.user.value?.id)) +
        1;
    controller.point.value = userPoints[userController.user.value?.id] ?? 0;

    controller.isLoading.value = false;
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
        usersList.map((doc) => doc.id).cast<String>().toList();
    final List<Map<String, dynamic>> exams = [];

    final DateTime startOfMonth =
        DateTime(DateTime.now().year, DateTime.now().month, 1);
    final DateTime endOfMonth =
        DateTime(DateTime.now().year, DateTime.now().month + 1, 0, 23, 59, 59);

    for (final userId in userIds) {
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
      final String userId = exam['userId'];
      final int pointsEarned = exam['points'];

      userPoints[userId] = (userPoints[userId] ?? 0) + pointsEarned;
    }
    return userPoints;
  }

  Future<void> fetchProfileImages() async {
    for (var user in usersList.getRange(0, 3)) {
      try {
        topUsersProfile[user.id ?? ""] =
            user.userProfileImgUrl!; // Store URL in the map
      } catch (e) {
        // Handle errors (e.g., missing image)
        print("No Image because: ${e.toString()}");
        topUsersProfile[user.id ?? ""] =
            ''; // Fallback to a default or empty URL
      }
    }
  }
}
