import 'package:flutter/material.dart';
import 'package:netflix/core/extensions/color_extensions.dart';

class TextFormFieldCustom extends StatelessWidget {
  const TextFormFieldCustom({
    super.key,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.suffixOnClick,
    this.hintColor,
    this.onChanged,
    bool? obscureText,
  }) : _obscureText = obscureText ?? false;

  final bool _obscureText;
  final String hintText;
  final Color? hintColor;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final void Function()? suffixOnClick;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53,
      padding: const EdgeInsets.only(top: 2),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.red.shade100.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: _obscureText,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: prefixIcon != null
              ? const EdgeInsets.only(top: 11)
              : const EdgeInsets.only(top: 11, left: 20),
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: context.accentColor,
              width: 1.8,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: hintColor),
          suffixIcon: suffixIcon != null
              ? InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: suffixOnClick,
                  child: Icon(suffixIcon),
                )
              : const SizedBox.shrink(),
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: context.secondaryColor,
                )
              : null,
        ),
      ),
    );
  }
}
