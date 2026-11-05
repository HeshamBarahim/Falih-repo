import 'package:falih/src/services/version_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isUpdateRequired', () {
    test('an older install must update', () {
      expect(isUpdateRequired(installedBuild: '13', requiredBuild: '14'), isTrue);
    });
    test('the same build is fine', () {
      expect(isUpdateRequired(installedBuild: '14', requiredBuild: '14'), isFalse);
    });
    test('a NEWER build (staged rollout, testers) is never blocked', () {
      expect(isUpdateRequired(installedBuild: '15', requiredBuild: '14'), isFalse);
    });
    test('compares numbers, not strings ("9" is older than "10")', () {
      expect(isUpdateRequired(installedBuild: '9', requiredBuild: '10'), isTrue);
    });
    test('never blocks on missing or unreadable config', () {
      expect(isUpdateRequired(installedBuild: '13', requiredBuild: null), isFalse);
      expect(isUpdateRequired(installedBuild: '13', requiredBuild: ''), isFalse);
      expect(isUpdateRequired(installedBuild: '13', requiredBuild: 'abc'), isFalse);
      expect(isUpdateRequired(installedBuild: 'x', requiredBuild: '14'), isFalse);
    });
  });

  group('pickRequiredBuild', () {
    test('finds the document that carries VersionCode, wherever it is', () {
      final docs = [
        {'api_url': 'https://relay.example'},
        {'VersionCode': '14', 'VersionName': '1.0.13'},
      ];
      expect(pickRequiredBuild(docs), '14');
    });
    test('accepts a numeric VersionCode', () {
      expect(pickRequiredBuild([{'VersionCode': 14}]), '14');
    });
    test('returns null when no document has one', () {
      expect(pickRequiredBuild([{'a': 1}]), isNull);
      expect(pickRequiredBuild([]), isNull);
    });
  });
}
