import 'package:falih/src/services/notification_message.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime(2026, 11, 5, 14, 7);

  test('builds a stored notification from title, body and send time', () {
    final n = notificationFromMessage(
        title: 'Hi', body: 'Body', sentTime: DateTime(2026, 3, 5, 7, 9), now: now)!;
    expect(n.title, 'Hi');
    expect(n.subTitle, 'Body');
    expect(n.date, '5/3/2026 - 07:09');
  });

  test('a data-only message (no title, no body) produces nothing instead of crashing', () {
    expect(notificationFromMessage(title: null, body: null, sentTime: null, now: now), isNull);
    expect(notificationFromMessage(title: '', body: '  ', sentTime: null, now: now), isNull);
  });

  test('title without body is kept, with an empty subtitle', () {
    final n = notificationFromMessage(title: 'Only title', body: null, sentTime: null, now: now)!;
    expect(n.title, 'Only title');
    expect(n.subTitle, '');
  });

  test('a missing send time falls back to now', () {
    final n = notificationFromMessage(title: 'T', body: 'B', sentTime: null, now: now)!;
    expect(n.date, '5/11/2026 - 14:07');
  });
}
