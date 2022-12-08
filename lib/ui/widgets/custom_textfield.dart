import 'package:flutter/material.dart';
import 'package:tes_app_idstar/theme.dart';

class CustomTextField extends StatelessWidget {
  final String? title;
  final String? hintText;
  final TextEditingController? textEditingController;
  final bool? obscureText;
  final double? widthIcon;
  final double? heightIcon;
  final Widget? widget;
  final TextInputType? textInputType;

  CustomTextField({
    this.title,
    this.hintText,
    this.textEditingController,
    this.obscureText,
    this.widthIcon,
    this.heightIcon,
    this.widget,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          title ?? '',
          style: blackTextStyle.copyWith(
            fontSize: 16,
          ),
        ),

        title != null
            ? const SizedBox(
                height: 6,
              )
            : const SizedBox(),

        // TextField
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F0F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            keyboardType: textInputType ?? TextInputType.text,
            controller: textEditingController,
            obscureText: obscureText ?? false,
            style: blackTextStyle.copyWith(),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: greyTextStyle.copyWith(
                color: const Color(0xFF515151),
              ),
              suffixIcon: widget ?? const SizedBox(),
            ),
          ),
        ),
      ],
    );
  }
}
