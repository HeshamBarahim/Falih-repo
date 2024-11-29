import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String phoneNo;
  final String fakeEmail;
  final String schoolName;
  final String? selectedGovernorate;
  final String? selectedGrade;

  // Authentication will handle login logout for us.
  final String? password;

  /// Constructor
  const UserModel({
    this.id,
    this.password,
    required this.fullName,
    required this.phoneNo,
    required this.fakeEmail,
    required this.schoolName,
    required this.selectedGovernorate,
    required this.selectedGrade,
  });

  // convert model to Json structure so that you can use it to store data in Firebase
  toJson() {
    return {
      "FullName": fullName,
      "Phone": phoneNo,
      "fakeEmail": fakeEmail,
      "School Name": schoolName,
      "Governoroate": selectedGovernorate,
      "Grade": selectedGrade,
    };
  }

  /// Empty Constructor for UserModel
  static UserModel empty() => const UserModel(
      id: '',
      fullName: '',
      phoneNo: '',
      fakeEmail: '',
      selectedGovernorate: '',
      schoolName: '',
      selectedGrade: '');

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    // If document is empty then return an empty Model as created above.
    if (document.data() == null || document.data()!.isEmpty) {
      return UserModel.empty();
    }
    final data = document.data()!;
    return UserModel(
      id: document.id,
      fullName: data["FullName"] ?? '',
      phoneNo: data["Phone"] ?? '',
      fakeEmail: data["Fake Email"] ?? '',
      selectedGovernorate: data["Governoroate"] ?? '',
      schoolName: data["School Name"] ?? '',
      selectedGrade: data["Grade"] ?? '',
    );
  }
}
