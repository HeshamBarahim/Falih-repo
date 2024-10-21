import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.name,
    required this.color,
  });
  final String name;
  final LinearGradient color;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(gradient: color),
      ),
      title: Text(name),
    );
  }
}
