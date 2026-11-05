import 'package:falih/src/controller/account_deletion_controller.dart';
import 'package:falih/src/services/auth_backend.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/fake_auth_backend.dart';

void main() {
  late FakeAuthBackend backend;
  late List<String> steps;

  AccountDeletionController build({
    Future<void> Function(String)? reauth,
  }) {
    return AccountDeletionController(
      backend: backend,
      reauthenticate: reauth ?? (p) async => steps.add('reauth:$p'),
      signOut: () async => steps.add('signOut'),
    );
  }

  setUp(() {
    backend = FakeAuthBackend();
    steps = [];
  });

  test('re-authenticates, deletes on the server, then signs out - in that order', () async {
    final c = build();
    final result = await c.deleteAccount('secret1');
    expect(result, DeleteAccountResult.success);
    expect(steps, ['reauth:secret1', 'signOut']);
    expect(backend.calls, ['deleteAccount']);
    expect(c.isDeleting.value, isFalse);
  });

  test('a wrong password stops before anything is deleted', () async {
    final c = build(reauth: (_) async => throw const WrongPasswordException());
    expect(await c.deleteAccount('nope'), DeleteAccountResult.wrongPassword);
    expect(backend.calls, isEmpty);
    expect(steps, isEmpty);
  });

  test('a server failure keeps the user signed in', () async {
    backend.failWith = AuthFailure('internal');
    final c = build();
    expect(await c.deleteAccount('secret1'), DeleteAccountResult.failed);
    expect(steps, ['reauth:secret1']); // never signed out
    expect(c.isDeleting.value, isFalse);
  });

  test('an empty password is rejected without calling anything', () async {
    final c = build();
    expect(await c.deleteAccount('  '), DeleteAccountResult.wrongPassword);
    expect(steps, isEmpty);
    expect(backend.calls, isEmpty);
  });

  test('ignores a second tap while a deletion is running', () async {
    final c = build();
    final first = c.deleteAccount('secret1');
    expect(await c.deleteAccount('secret1'), DeleteAccountResult.failed);
    await first;
    expect(backend.calls, ['deleteAccount']);
  });
}
