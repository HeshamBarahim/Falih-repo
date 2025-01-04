import 'package:rive/rive.dart';

class RiveAsset {
  int index;
  final String artboard, stateMachineName, src;
  late SMIBool? input;
  final String Function() title;

  RiveAsset(this.src,
      {required this.index,
      required this.artboard,
      required this.stateMachineName,
      required this.title,
      this.input});

  set setInput(SMIBool status) {
    input = status;
  }
}
