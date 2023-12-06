import 'package:flutter/material.dart';

class DefaultFormField extends StatelessWidget {
  TextInputType type;
  TextEditingController controller;
  String? label;
  String? hint;
  IconData? preficon;
  IconData? sufficon;
  String? Function(String?)? validator;
  InputBorder? inputBorder;
  Color? fillColor;
  Color? labelColor;
  Color? hintColor;
  Color? cursorColor;
  Color? prefixColor;
  double? prefixIconSize;
  void Function()? suffixPreesed;
  void Function(String)? onSubmit;
  void Function(String)? onChange;
  TextStyle? style;
  bool isObsecure;
  void Function()? onTab;

  DefaultFormField({super.key,
    required this.type,
    required this.controller,
    this.label,
    this.hint,
    this.preficon,
    this.sufficon,
    this.validator,
    this.inputBorder,
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
    return  TextFormField(
      style: style,
      keyboardType: type,
      controller: controller,
      validator: validator,
      obscureText: isObsecure,
      cursorColor: cursorColor,
      decoration: InputDecoration(
        fillColor: fillColor,
        labelStyle: TextStyle(
          color: labelColor,
        ),
        border: inputBorder,
        labelText: label,
        hintText: hint,
        hintStyle: TextStyle(
          color: hintColor,
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
    );
  }
}





