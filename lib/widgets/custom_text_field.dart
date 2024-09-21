import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final double? height;
  final double? width;
  final Color bgColor;
  final TextStyle? hintStyle;
  final BorderRadius? borderRadius;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  final bool? obsecureText;
  final Widget? prefix;
  final ValueChanged<String>? onChange;
  final int? maxLength;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final InputBorder? border;
  final int? maxLines;
  final isEnabled;
  var contBorder;
  var enteredTextColor;
  var contentPadding;
  bool autoFocus;

  CustomTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.height,
    this.width,
    this.bgColor = const Color(0xFFCACBCC),
    this.hintStyle,
    this.borderRadius,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.obsecureText,
    this.prefix,
    this.onChange,
    this.maxLength,
    this.textAlign,
    this.keyboardType,
    this.border,
    this.maxLines,
    this.isEnabled,
    this.contBorder,
    this.enteredTextColor,
    this.contentPadding,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 371,
      height: height ?? 47,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius ?? BorderRadius.circular(4),
        border: contBorder ??
            Border.all(
              width: 1,
              color: const Color(0xFF4F4F4F),
            ),
      ),
      child: Row(
        children: [
          if (prefix != null) prefix!,
          Expanded(
            child: TextField(
              autofocus: autoFocus,
              enabled: isEnabled ?? true,
              controller: controller,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  counterText: '',
                  prefixIcon: null,
                  hintText: labelText,
                  border: InputBorder.none,
                  hintStyle: hintStyle ??
                      const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                  contentPadding: contentPadding ??
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  suffixIcon: suffixIcon,
                  suffixIconConstraints: const BoxConstraints(
                    maxHeight: 25,
                  )),
              style: TextStyle(
                fontSize: 16,
                color: enteredTextColor ?? Colors.white,
              ),
              obscureText: obsecureText ?? false,
              onChanged: onChange,
              maxLength: maxLength,
              textAlign: textAlign ?? TextAlign.left,
              keyboardType: keyboardType,
              maxLines: maxLines ?? 1,
            ),
          ),
        ],
      ),
    );
  }
}
