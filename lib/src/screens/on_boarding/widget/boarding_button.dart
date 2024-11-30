import 'package:falih/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoardingButton extends StatelessWidget {
  const BoardingButton({super.key, required this.onClick});

  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w,
      height: 60.h,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.black.withOpacity(0.5)),
      child: MaterialButton(
        height: 40.h,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        textColor: Colors.white,
        onPressed: onClick,
        child: Text(
          S.of(context).next,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
        ),
      ),
    );
  }
}
