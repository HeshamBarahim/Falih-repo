import 'package:falih/src/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const user = UserModel(
    fullName: 'Ali',
    userName: 'ali_1',
    phoneNo: '771234567',
    fakeEmail: '771234567@users.falih.invalid',
    isVerified: 'true',
    schoolName: 'S',
    selectedGovernorate: 'Sanaa',
    selectedGrade: '12',
    selectedDepartment: 'Science',
    selectedGender: 'M',
  );

  test('fakeEmail survives a write/read round trip (audit issue 10)', () {
    final back = UserModel.fromMap('uid1', user.toJson());
    expect(back.fakeEmail, '771234567@users.falih.invalid');
    expect(back.id, 'uid1');
    expect(back.phoneNo, '771234567');
  });

  test('still reads legacy documents that used the "Fake Email" key', () {
    final json = Map<String, dynamic>.from(user.toJson())
      ..remove('fakeEmail')
      ..['Fake Email'] = '771234567@gmail.com';
    expect(UserModel.fromMap('uid1', json).fakeEmail, '771234567@gmail.com');
  });

  test('an empty document gives the empty model', () {
    expect(UserModel.fromMap('uid1', {}).fullName, '');
  });
}
