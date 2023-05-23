import 'package:flutter/material.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/design_system/utils/colors.dart';

/// The TAPrimaryButton class is a stateless widget that displays a button
/// with customizable text, color, and tap event handling, and can show a
/// loading indicator when tapped.
class TAPrimaryButton extends StatelessWidget {
  /// Constructor
  const TAPrimaryButton({
    required this.text,
    required this.onTap,
    super.key,
    this.isLoading = false,
    this.color = TAColors.primary,
  });

  /// The text that is displayed on the button.
  final String text;

  /// The color of the button.
  final Color color;

  /// A callback that is used to handle the tap event.
  final VoidCallback onTap;

  /// A boolean that is used to show a loading indicator when the button
  /// is tapped.
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: 58,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isLoading ? color.withOpacity(0.3) : color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: isLoading
            ? const SizedBox(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : TATypography.paragraph(
                text: text,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
      ),
    );
  }
}
