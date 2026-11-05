import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? userProfileImgUrl;
  final String fullName;
  final String? userName;
  final String phoneNo;
  final String fakeEmail;
  final String? isVerified;
  final String schoolName;
  final String? selectedGovernorate;
  final String? selectedGrade;
  final String? selectedDepartment;
  final String? selectedGender;

  // Authentication will handle login logout for us.
  final String? password;

  /// Constructor
  const UserModel({
    this.id,
    this.password,
    this.userProfileImgUrl,
    this.userName,
    required this.fullName,
    required this.phoneNo,
    required this.fakeEmail,
    this.isVerified,
    required this.schoolName,
    required this.selectedGovernorate,
    required this.selectedGrade,
    required this.selectedDepartment,
    required this.selectedGender,
  });

  // convert model to Json structure so that you can use it to store data in Firebase
  toJson() {
    return {
      'userProfileImgUrl': userProfileImgUrl,
      "FullName": fullName,
      "UserName": userName,
      "Phone": phoneNo,
      "fakeEmail": fakeEmail,
      "IsVerified": isVerified,
      "School Name": schoolName,
      "Governoroate": selectedGovernorate,
      "Grade": selectedGrade,
      "Department": selectedDepartment,
      "Gender": selectedGender,
    };
  }

  /// Empty Constructor for UserModel
  static UserModel empty() => const UserModel(
        id: '',
        userProfileImgUrl: '',
        fullName: '',
        userName: '',
        phoneNo: '',
        fakeEmail: '',
        isVerified: '',
        selectedGovernorate: '',
        schoolName: '',
        selectedGrade: '',
        selectedDepartment: '',
        selectedGender: '',
      );

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    return UserModel.fromMap(document.id, document.data() ?? {});
  }

  /// Build from raw document data. Reads both the current `fakeEmail` key and
  /// the `Fake Email` key some older code looked for.
  factory UserModel.fromMap(String id, Map<String, dynamic> data) {
    // If the document is empty then return an empty Model as created above.
    if (data.isEmpty) return UserModel.empty();
    return UserModel(
      id: id,
      userProfileImgUrl: data['userProfileImgUrl'] ?? '',
      fullName: data["FullName"] ?? '',
      userName: data["UserName"] ?? '',
      phoneNo: data["Phone"] ?? '',
      fakeEmail: data["fakeEmail"] ?? data["Fake Email"] ?? '',
      isVerified: data["IsVerified"] ?? '',
      selectedGovernorate: data["Governoroate"] ?? '',
      schoolName: data["School Name"] ?? '',
      selectedGrade: data["Grade"] ?? '',
      selectedDepartment: data["Department"] ?? '',
      selectedGender: data["Gender"] ?? '',
    );
  }
}
