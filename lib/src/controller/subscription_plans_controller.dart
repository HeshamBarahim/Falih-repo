import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SubscriptionPlansController extends GetxController {
  final plans = <Map<String, dynamic>>[].obs; // Observable list for plans
  final isLoading = true.obs;
  final errorMessage = ''.obs; // Observable for error messages
  var selectedClass = 9.obs;
  var selectedSection = "english".obs;
  var selectedPlan =
      Rxn<Map<String, dynamic>>(); // Observable variable for selected plan

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchAllPlans(); // Fetch plans when the controller is initialized
  }

  Future<void> fetchAllPlans() async {
    try {
      isLoading(true);
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('plans').get();

      final fetchedPlans = snapshot.docs.map((doc) {
        return {
          "id": doc.id,
          "name": doc["name"],
          "price": doc["price"],
          "description": doc["description"],
          "features": doc["features"],
          "class": doc["class"],
          "isActive": doc["isActive"],
          "durationInDays": doc["durationInDays"],
          "section": doc["section"],
          "unitExamLimit": doc["unitExamLimit"],
          "finalExamLimit": doc["finalExamLimit"],
          "type": doc["type"]
        };
      }).toList();

      plans.assignAll(fetchedPlans); // Update the observable list
    } catch (e) {
      errorMessage('Failed to fetch plans: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchPlansByClassAndSection(
      int classNumber, String section) async {
    try {
      isLoading(true);
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('plans')
              .where('class', isEqualTo: classNumber)
              .where('section', isEqualTo: section)
              .where('isActive', isEqualTo: true)
              .get();

      final fetchedPlans = snapshot.docs.map((doc) => doc.data()).toList();
      plans.assignAll(fetchedPlans); // Update the observable list
    } catch (e) {
      errorMessage('Failed to fetch plans: $e');
    } finally {
      isLoading(false);
    }
  }

  // Set the selected plan
  void selectPlan(Map<String, dynamic> plan) {
    selectedPlan.value = plan;
  }

  // Filtered plans based on selected class
  List<Map<String, dynamic>> get filteredPlans {
    return plans.where((plan) {
      return plan['section'] == selectedSection.value;
    }).toList();
  }

  // Change class filter
  void selectClass(int className) {
    selectedClass.value = className;
    filteredPlans;
    // addPlans();
  }

  void selectSection(String sectionName) {
    selectedSection.value = sectionName;
    filteredPlans;
    // addPlans();
  }

  Future<void> addPlans() async {
    await FirebaseFirestore.instance
        .collection('plans')
        .doc('3-MonthDurationPlan12Arabic') // Custom ID
        .set({
      "name": "3-Month Plan",
      "class": 12,
      "section": "arabic",
      "type": "duration-based",
      "price": 6500,
      "durationInDays": 90,
      "unitExamLimit": null,
      "finalExamLimit": null,
      "description":
          "Suitable for students preparing for a few key exams in Class 12.",
      "features": ["Feature 1", "Feature 2", "Feature 3"],
      "isActive": true,
      "createdAt": FieldValue.serverTimestamp(),
      "updatedAt": FieldValue.serverTimestamp()
    });
  }

// void submitPlan(String id) {
//   print(
//       "Selected plan ID: $id"); // Check if this is called and if the ID is correct
//   selectedPlan.value = id;
// }
}
