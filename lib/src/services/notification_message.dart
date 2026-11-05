class StoredNotification {
  const StoredNotification(
      {required this.title, required this.subTitle, required this.date});
  final String title;
  final String subTitle;
  final String date;
}

String formatNotificationDate(DateTime t) =>
    '${t.day}/${t.month}/${t.year} - '
    '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

/// Turns the pieces of a push message into what the app stores. Returns null
/// for data-only messages (nothing to show), instead of throwing.
StoredNotification? notificationFromMessage({
  required String? title,
  required String? body,
  required DateTime? sentTime,
  required DateTime now,
}) {
  final t = (title ?? '').trim();
  final b = (body ?? '').trim();
  if (t.isEmpty && b.isEmpty) return null;
  return StoredNotification(
    title: t,
    subTitle: b,
    date: formatNotificationDate(sentTime ?? now),
  );
}
