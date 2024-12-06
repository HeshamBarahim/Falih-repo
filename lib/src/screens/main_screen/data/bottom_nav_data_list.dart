import '../models/rive_asset.dart';

List<RiveAsset> bottomNavDataList = [
  RiveAsset(
    "assets/RiveAssets/icons.riv",
    index: 0,
    artboard: "HOME",
    stateMachineName: "HOME_interactivity",
    title: "Home",
  ),
  RiveAsset(
    "assets/RiveAssets/icons.riv",
    index: 1,
    artboard: "TIMER",
    stateMachineName: "TIMER_Interactivity",
    title: "Status",
  ),
  RiveAsset(
    "assets/RiveAssets/icons.riv",
    index: 2,
    artboard: "SETTINGS",
    stateMachineName: "SETTINGS_Interactivity",
    title: "Control",
  ),
  RiveAsset("assets/RiveAssets/icons.riv",
      index: 3,
      artboard: "TIMER",
      stateMachineName: "TIMER_Interactivity",
      title: "History"),
  
  RiveAsset(
    "assets/RiveAssets/icons.riv",
    index: 4,
    artboard: "BELL",
    stateMachineName: "BELL_Interactivity",
    title: "Notification",
  ),
];
