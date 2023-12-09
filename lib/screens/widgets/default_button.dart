import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final double width;
  final Color backgroundColor;
  final Color borderColor;
  final bool isUpperCase;
  final double radius;
  final String text;
  final AlignmentGeometry alignment;
  final Function function;

  DefaultButton({
    super.key,
    this.width = 150.0,
    required this.backgroundColor,
    this.borderColor = Colors.transparent,
    this.isUpperCase = true,
    this.radius = 15.0,
    required this.text,
    required this.function,
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: width,
        height: 50.0,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: MaterialButton(
          color: backgroundColor,
          onPressed: () {
            function();
          },
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
