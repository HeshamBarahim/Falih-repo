import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var userExamHistoryIsLoading = true.obs;
  var carouselCurrentIndex = 0.obs;
  var overallPoints = 0.obs;
  var point = 0.obs;
  var rank = 0.obs;
  var maxPoint = 500.obs;
  final _db = FirebaseFirestore.instance;
  RxList<Map<String, dynamic>> userExamHistory = <Map<String, dynamic>>[].obs;

  @override
  Future<void> onInit() async {
    await fetchAllUserExamHistory();
    super.onInit();
  }

  Future<void> fetchAllUserExamHistory() async {
    userExamHistoryIsLoading.value = true;
    overallPoints.value = 0;

    var user = UserController.instance.user.value;
    final QuerySnapshot userExamsSnapshot = await _db
        .collection('exams')
        .doc(user?.id)
        .collection('userExams')
        .get();
    userExamHistory.addAll(userExamsSnapshot.docs.map((doc) {
      final examData = doc.data() as Map<String, dynamic>;
      overallPoints += examData["points"] ?? 0;
      return examData;
    }));

    // Sort by a specific field, e.g., "examDate"
    userExamHistory.sort((a, b) {
      final dateA = a['date'];
      final dateB = b['date'];
      return dateB.compareTo(dateA);
    });
    userExamHistoryIsLoading.value = false;
  }
}
