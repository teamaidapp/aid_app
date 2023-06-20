import 'package:flutter/material.dart';
import 'package:team_aid/design_system/design_system.dart';

/// The TAPrimaryButton class is a stateless widget that displays a button
/// with customizable text, color, and tap event handling, and can show a
/// loading indicator when tapped.
class TASecondaryButton extends StatelessWidget {
  /// Constructor
  const TASecondaryButton({
    required this.text,
    required this.onTap,
    super.key,
    this.height = 40,
    this.isLoading = false,
    this.color = TAColors.purple,
    this.padding = const EdgeInsets.symmetric(horizontal: 32),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
  });

  /// The text that is displayed on the button.
  final String text;

  /// The height of the button.
  final double height;

  /// The color of the button.
  final Color color;

  /// A callback that is used to handle the tap event.
  final VoidCallback onTap;

  /// The alignment of the text and icon.
  final MainAxisAlignment mainAxisAlignment;

  /// The padding of the text and icon.
  final EdgeInsets padding;

  /// A boolean that is used to show a loading indicator when the button
  /// is tapped.
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: height,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: color,
            width: 1.5,
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: Colors.white,
                ),
              )
            : Padding(
                padding: padding,
                child: TATypography.paragraph(
                  text: text,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
