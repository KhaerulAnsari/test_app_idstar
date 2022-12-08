import 'package:flutter/material.dart';
import 'package:tes_app_idstar/theme.dart';

class CustomButton extends StatelessWidget {
  final Function? onPressed;
  final String title;
  final Color? color;
  const CustomButton(
      {super.key, this.onPressed, required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? blueColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        title,
        style: textStyle.copyWith(
          color: whiteColor,
          fontSize: 16,
        ),
      ),
    );
  }
}
