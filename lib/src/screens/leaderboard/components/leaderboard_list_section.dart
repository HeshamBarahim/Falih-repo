import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:falih/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaderboardListSection extends StatelessWidget {
  final String id;
  final String name;
  final String userName;
  final int points;
  final int rank;

  LeaderboardListSection({
    super.key,
    required this.id,
    required this.name,
    required this.userName,
    required this.points,
    required this.rank,
  });

  final UserModel? user = UserController.instance.user.value;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.screenHeight! * 0.015,
        horizontal: SizeConfig.screenWidth! * 0.04,
      ),
      color: id == user?.id.toString()
          ? Theme.of(context).colorScheme.secondary
          : Theme.of(context).colorScheme.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.12,
                height: MediaQuery.of(context).size.width * 0.12,
                // Ensure it's a perfect circle
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: id == user?.id.toString()
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary,
                ),
                alignment: Alignment.center,
                // Centers the text
                child: Text("#$rank",
                    style: id == user?.id.toString()
                        ? Theme.of(context).textTheme.bodySmall
                        : Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary)),
              ),
              SizedBox(width: SizeConfig.screenWidth! * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name.capitalize ?? "",
                      style: id == user?.id.toString()
                          ? Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary)
                          : Theme.of(context).textTheme.titleSmall),
                  Text(userName.capitalize ?? "",
                      style: id == user?.id.toString()
                          ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary)
                          : Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text('$points',
                  style: id == user?.id.toString()
                      ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary)
                      : Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }
}
