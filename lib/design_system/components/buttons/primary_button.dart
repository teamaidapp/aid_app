import 'package:flutter/material.dart';
import 'package:team_aid/design_system/design_system.dart';

/// The TAPrimaryButton class is a stateless widget that displays a button
/// with customizable text, color, and tap event handling, and can show a
/// loading indicator when tapped.
class TAPrimaryButton extends StatelessWidget {
  /// Constructor
  const TAPrimaryButton({
    required this.text,
    required this.onTap,
    super.key,
    this.icon,
    this.height = 40,
    this.isLoading = false,
    this.isDisabled = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 32),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
  });

  /// The text that is displayed on the button.
  final String text;

  /// The height of the button.
  final double height;

  /// A callback that is used to handle the tap event.
  final VoidCallback onTap;

  /// An optional icon that is displayed on the button.
  final IconData? icon;

  /// The alignment of the text and icon.
  final MainAxisAlignment mainAxisAlignment;

  /// The padding of the text and icon.
  final EdgeInsets padding;

  /// A boolean that is used to show a loading indicator when the button
  /// is tapped.
  final bool isLoading;

  /// Check if the buttons should be disabled
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isDisabled) onTap();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: height,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [Color(0xff376aed), Color(0xff7d6efb)],
            stops: [0, 1],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
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
                child: Row(
                  mainAxisAlignment: mainAxisAlignment,
                  children: [
                    TATypography.paragraph(
                      text: text,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    if (icon != null) Icon(icon, color: Colors.white)
                  ],
                ),
              ),
      ),
    );
  }
}
