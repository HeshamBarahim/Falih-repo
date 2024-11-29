import 'package:flutter/material.dart';

class BoardingButton extends StatelessWidget {
  const BoardingButton({super.key, required this.onClick});

  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 60,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.black.withOpacity(0.5)),
      child: MaterialButton(
        height: 40,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        textColor: Colors.white,
        onPressed: onClick,
        child: const Text(
          'Next',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
