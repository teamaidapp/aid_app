import 'package:flutter/material.dart';

import 'package:team_aid/design_system/components/typography/styles.dart';

/// The TATypography class is a customizable text widget in Dart that allows for
/// easy creation of
/// different text styles.
class TATypography extends StatelessWidget {
  /// This is a constructor for the `TATypography` class that creates a text
  /// widget with the style of an h1 heading. It takes in parameters such as
  /// `text`, `underline`, `textAlign`, `color`, and `fontWeight` which are used
  /// to customize the text style. The `super.key` parameter is used to pass
  /// a key to the superclass constructor. The `: style = h1Style` part
  /// initializes the `style` property
  /// of the `TATypography` class to the `h1Style` constant, which is a
  /// predefined text style for h1 headings.
  TATypography.h1({
    required this.text,
    super.key,
    this.underline = false,
    this.textAlign = TextAlign.left,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w600,
  }) : style = h1Style;

  /// This is a constructor for the `TATypography` class that creates a text
  /// widget with the style of an h2 heading. It takes in parameters such as
  /// `text`, `underline`, `textAlign`, `color`, and `fontWeight` which are used
  /// to customize the text style.
  TATypography.h2({
    required this.text,
    super.key,
    this.underline = false,
    this.textAlign = TextAlign.left,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w600,
  }) : style = h2Style;

  /// This is a constructor for the `TATypography` class that creates a text
  /// widget with the style of an h3 heading. It takes in parameters such as
  /// `text`, `underline`, `textAlign`, `color`, and `fontWeight` which are used
  /// to customize the text style.
  TATypography.h3({
    required this.text,
    super.key,
    this.underline = false,
    this.textAlign = TextAlign.left,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w600,
  }) : style = h3Style;

  /// This is a constructor for the `TATypography` class that creates a text
  /// widget with the style of an h4 heading. It takes in parameters such as
  /// `text`, `underline`, `textAlign`, `color`, and `fontWeight` which are used
  /// to customize the text style.
  TATypography.paragraph({
    required this.text,
    super.key,
    this.underline = false,
    this.textAlign = TextAlign.left,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w400,
  }) : style = parapraphStyle;

  /// This is a constructor for the `TATypography` class that creates a text
  /// widget with the style of an h5 heading. It takes in parameters such as
  /// `text`, `underline`, `textAlign`, `color`, and `fontWeight` which are used
  /// to customize the text style.
  TATypography.subparagraph({
    required this.text,
    super.key,
    this.underline = false,
    this.textAlign = TextAlign.left,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w400,
  }) : style = subParapraphStyle;

  /// The text that is displayed.
  final String text;

  /// The color of the text.
  final Color color;

  /// A boolean that is used to underline the text.
  final bool underline;

  /// The style of the text.
  final TextStyle style;

  /// The weight of the text.
  final FontWeight fontWeight;

  /// The alignment of the text.
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
