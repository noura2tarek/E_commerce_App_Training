import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final double width;
  final Color backgroundColor;
  final Color borderColor;

  final double radius;
  final AlignmentGeometry alignment;
  final Function function;
  final Widget buttonWidget;
  final height;

  const DefaultButton({
    super.key,
    required this.buttonWidget,
    this.width = 150.0,
    this.height = 50.0,
    required this.backgroundColor,
    this.borderColor = Colors.transparent,
    this.radius = 16.0,
    required this.function,
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(radius),
          color: backgroundColor,
        ),
        child: MaterialButton(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
          onPressed: () {
            function();
          },
          child: buttonWidget,
        ),
      ),
    );
  }
}
/*
Text(
            isUpperCase ? text.toUpperCase() : text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15.0,
            ),
 */
