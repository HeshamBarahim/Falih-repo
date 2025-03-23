import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var userExamHistoryIsLoading = true.obs;
  var carouselCurrentIndex = 0.obs;
  var overallPoints = 0.obs;
  var monthlyPoints = 0.obs;
  var rank = 0.obs;
  var maxPoint = 500.obs;
  final _db = FirebaseFirestore.instance;
  RxList<Map<String, dynamic>> userExamHistory = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> visibleExams = <Map<String, dynamic>>[].obs;
  final RxInt currentExamItemCount = 10.obs; // Reactive current item count

  @override
  Future<void> onInit() async {
    await fetchAllUserExamHistory();
    super.onInit();
  }

  Future<void> fetchAllUserExamHistory() async {
    userExamHistory.clear();
    userExamHistoryIsLoading.value = true;
    overallPoints.value = 0;
    monthlyPoints.value = 0;

    var user = UserController.instance.user.value;
    final QuerySnapshot userExamsSnapshot = await _db
        .collection('exams')
        .doc(user?.id)
        .collection('userExams')
        .get();

    userExamHistory.addAll(userExamsSnapshot.docs.map((doc) {
      final examData = doc.data() as Map<String, dynamic>;
      Timestamp? examTimestamp = examData["date"];
      if (examTimestamp != null) {
        DateTime examDate = examTimestamp.toDate();

        final DateTime now = DateTime.now();

        final int currentMonth = now.month;
        final int currentYear = now.year;
        // Check if the exam is in the current month and year
        if (examDate.month == currentMonth && examDate.year == currentYear) {
          monthlyPoints += examData["points"] ?? 0;
        }
      }
      overallPoints += examData["points"] ?? 0;
      return examData;
    }));

    // Sort by a specific field, e.g., "examDate"
    userExamHistory.sort((a, b) {
      final dateA = a['date'];
      final dateB = b['date'];
      return dateB.compareTo(dateA);
    });
    visibleExams.value =
        userExamHistory.take(currentExamItemCount.value).toList();
    userExamHistoryIsLoading.value = false;
  }

  void loadMore() {
    // Increment the item count by 10 or up to the total list size
    if (currentExamItemCount.value < userExamHistory.length) {
      currentExamItemCount.value += 10;
    }

    // Reactive UI updates when currentItemCount changes
    visibleExams.value =
        userExamHistory.take(currentExamItemCount.value).toList();
  }
}
