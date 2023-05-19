import 'package:flutter/material.dart';

import 'styles.dart';

class TATypography extends StatelessWidget {
  TATypography.h1({
    required this.text,
    super.key,
    this.underline = false,
    this.textAlign = TextAlign.left,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w600,
  }) : style = h1Style;
  TATypography.h2({
    required this.text,
    super.key,
    this.underline = false,
    this.textAlign = TextAlign.left,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w600,
  }) : style = h2Style;
  TATypography.h3({
    required this.text,
    super.key,
    this.underline = false,
    this.textAlign = TextAlign.left,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w600,
  }) : style = h3Style;

  TATypography.paragraph({
    required this.text,
    super.key,
    this.underline = false,
    this.textAlign = TextAlign.left,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w400,
  }) : style = parapraphStyle;

  TATypography.subparagraph({
    required this.text,
    super.key,
    this.underline = false,
    this.textAlign = TextAlign.left,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w400,
  }) : style = subParapraphStyle;
  final String text;

  final Color color;

  final bool underline;

  final TextStyle style;

  final FontWeight fontWeight;

  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: style.copyWith(
        color: color,
        fontWeight: fontWeight,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}
