import 'package:falih/src/config/sizes.dart';
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget trailing;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ListTile(
      leading: Icon(
        icon,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
