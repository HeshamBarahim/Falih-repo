import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/sizes.dart';


class NavBarInfoCard extends StatelessWidget {
  final String name;
  final String profession;
  const NavBarInfoCard({
    super.key,
    required this.name,
    required this.profession,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ListTile(
      leading: CircleAvatar(
        radius: SizeConfig.screenHeight! * 0.03,
        backgroundColor: Colors.white24,
        child: Icon(
          CupertinoIcons.person,
          color: Colors.white,
          size: SizeConfig.screenHeight! * 0.04,
        ),
      ),
      title: Text(
        name,
        style: TextStyle(
          color: Colors.white,
          fontSize: SizeConfig.screenHeight! * 0.022,
        ),
      ),
      subtitle: Text(
        profession,
        style: TextStyle(
          color: Colors.white,
          fontSize: SizeConfig.screenHeight! * 0.018,
        ),
      ),
    );
  }
}
