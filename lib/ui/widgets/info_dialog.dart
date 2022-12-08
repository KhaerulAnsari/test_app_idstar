import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tes_app_idstar/theme.dart';

class InfoDialog extends StatelessWidget {
  final String? message;
  final Function? onPressed;
  const InfoDialog({
    Key? key,
    this.message,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      key: key,
      title: Image.asset(
        'images/info.png',
        height: 80,
      ),
      content: Text(
        message!,
        style: greyTextStyle.copyWith(
          fontSize: 16,
          fontWeight: regular,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        SizedBox(
          height: 40,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (onPressed != null) {
                onPressed!();
              }
            },
            child: Text(
              'Hapus',
              style: textStyle.copyWith(
                fontSize: 14,
                fontWeight: medium,
                color: whiteColor,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: blueColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        Center(
          child: TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'Batal',
              style: textStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
                color: orangeColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
