/// True only when the installed build is strictly older than the required one.
/// Missing or unreadable values never block the user.
bool isUpdateRequired({
  required String installedBuild,
  required String? requiredBuild,
}) {
  final installed = int.tryParse(installedBuild.trim());
  final required = int.tryParse((requiredBuild ?? '').trim());
  if (installed == null || required == null) return false;
  return installed < required;
}

/// The required build number from the `app_config` documents: the first one
/// that actually has a `VersionCode`, since the collection holds other documents.
String? pickRequiredBuild(Iterable<Map<String, dynamic>> docs) {
  for (final doc in docs) {
    final code = doc['VersionCode'];
    if (code != null) return code.toString();
  }
  return null;
}
