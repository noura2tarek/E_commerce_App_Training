import 'package:flutter/materiaL.dart';

class DefaultTextButton extends StatelessWidget {
  final String text;
  final void Function()? function;
  final FontWeight? fontWeight;
  final double? fontSize;

  const DefaultTextButton({
    required this.text,
    required this.function,
    this.fontWeight = FontWeight.w500,
    this.fontSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: function,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
