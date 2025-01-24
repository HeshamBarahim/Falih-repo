import 'package:falih/generated/l10n.dart';

import '../models/rive_asset.dart';

String translateHome() => S.current.home;

List<RiveAsset> sideMenuDataList_1 = [
  RiveAsset("assets/RiveAssets/icons.riv",
      index: 0,
      artboard: "HOME",
      stateMachineName: "HOME_interactivity",
      title: () => S.current.home),
  RiveAsset(
    "assets/RiveAssets/icons.riv",
    index: 1,
    artboard: "USER",
    stateMachineName: "USER_Interactivity",
    title: () => S.current.profile,
  ),
  RiveAsset(
    "assets/RiveAssets/icons.riv",
    index: 2,
    artboard: "LIKE/STAR",
    stateMachineName: "STAR_Interactivity",
    title: () => S.current.Subscription,
  ),
];

List<RiveAsset> sideMenuDataList_2 = [
  // RiveAsset(
  //   "assets/RiveAssets/icons.riv",
  //   index: 0,
  //   artboard: "TIMER",
  //   stateMachineName: "TIMER_Interactivity",
  //   title: "History",
  // ),

  RiveAsset(
    "assets/RiveAssets/icons.riv",
    index: 0,
    artboard: "USER",
    stateMachineName: "USER_Interactivity",
    title: () => S.current.about_us,
  ),
  RiveAsset(
    "assets/RiveAssets/icons.riv",
    index: 1,
    artboard: "SETTINGS",
    stateMachineName: "SETTINGS_Interactivity",
    title: () => S.current.settings,
  ),
  RiveAsset(
    "assets/RiveAssets/logout.riv",
    index: 2,
    artboard: "logout",
    stateMachineName: "LOGOUT_Interactivity",
    title: () => S.current.logout,
  ),
];
