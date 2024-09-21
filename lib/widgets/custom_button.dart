// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final borderRadius;
  final bgColor;
  final titleStyle;
  final border;
  Widget? prefixImage;
  Widget? suffixImage;
  final prefixWidth;
  final suffixWidth;

  CustomButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.height = 43,
    this.width = 371,
    this.bgColor,
    this.borderRadius,
    this.titleStyle,
    this.border,
    this.prefixImage,
    this.suffixImage,
    EdgeInsets? padding,
    this.prefixWidth,
    this.suffixWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          color: bgColor ?? Colors.black,
          border: border,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixImage != null) prefixImage!,
            if (prefixWidth != null) SizedBox(width: prefixWidth),
            Text(
              title,
              style: titleStyle ??
                  const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontFamily: "WorkSans",
                  ),
            ),
            if (suffixWidth != null) SizedBox(width: suffixWidth),
            if (suffixImage != null) suffixImage!,
          ],
        ),
      ),
    );
  }
}
