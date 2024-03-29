import 'package:flutter/material.dart';

class DefaultFormField extends StatelessWidget {
  final TextInputType type;
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final IconData? preficon;
  final IconData? sufficon;
  final String? Function(String?)? validator;
  final Color? fillColor;
  final Color? labelColor;
  final Color? hintColor;
  final Color? cursorColor;
  final Color? prefixColor;
  final double? prefixIconSize;
  final void Function()? suffixPreesed;
  final void Function(String)? onSubmit;
  final void Function(String)? onChange;
  final TextStyle? style;
  final bool isObsecure;
  final InputBorder? border;
  final double? height;
  final double? labelSize;
  final void Function()? onTab;

  const DefaultFormField({
    this.border,
    super.key,
    this.height = 55.0,
    this.labelSize = 14.0,
    required this.type,
    required this.controller,
    this.label,
    this.hint,
    this.preficon,
    this.sufficon,
    this.validator,
    this.fillColor,
    this.labelColor,
    this.hintColor,
    this.cursorColor,
    this.prefixColor,
    this.prefixIconSize,
    this.suffixPreesed,
    this.onSubmit,
    this.onChange,
    this.style,
    this.isObsecure = false,
    this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
        keyboardType: type,
        controller: controller,
        validator: validator,
        obscureText: isObsecure,
        cursorColor: cursorColor,
        decoration: InputDecoration(
          fillColor: fillColor,
          labelStyle: TextStyle(
            color: labelColor,
            fontSize: labelSize,
          ),
          border: border,
          labelText: label,
          hintText: hint,
          hintStyle: TextStyle(
            color: hintColor,
            fontSize: 15.0,
          ),
          prefixIcon: Icon(
            preficon,
            color: prefixColor,
            size: prefixIconSize,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              sufficon,
            ),
            onPressed: suffixPreesed,
          ),
        ),
        onTap: onTab,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
      ),
    );
  }
}
