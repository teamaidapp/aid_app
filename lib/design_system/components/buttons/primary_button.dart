import 'package:flutter/material.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/design_system/utils/colors.dart';

class TAPrimaryButton extends StatelessWidget {
  const TAPrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    this.color = TAColors.primary,
  });

  final String text;

  final Color color;

  final VoidCallback onTap;

  /// A boolean that is used to show a loading indicator when the button is tapped.
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
                  strokeWidth: 2.0,
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
