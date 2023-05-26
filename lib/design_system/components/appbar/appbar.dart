import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:team_aid/design_system/components/typography/typography.dart';

/// FZAppBar
class TAAppBar {
  /// Builds the app bar
  static AppBar build(
    BuildContext context, {
    String title = '',
    String secondTitle = '',
    IconData iconLeading = Icons.arrow_back_ios,

    /// Function that triggers when the button is tapped
    void Function()? onTap,

    /// Function that triggers when the button is tapped
    void Function()? onSecondaryActionTap,
    Color backgroundColor = Colors.transparent,

    /// Icon that shows up at the right
    IconData? icon,
    Color? iconColor,
    bool isIcon = true,
    bool showBackButton = true,
  }) {
    return AppBar(
      elevation: 0,
      titleSpacing: 0,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      title: Stack(
        children: [
          GestureDetector(
            onTap: onTap,
            child: showBackButton
                ? Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Row(
                      children: [
                        Icon(
                          iconLeading,
                          color: iconColor ?? Colors.black,
                        ),
                        // const SizedBox(width: 4),
                        // FZTypography(
                        //   text: 'Atrás',
                        //   textColor: iconColor ?? Colors.black,
                        //   fontWeight: FontWeight.bold,
                        //   type: FZTypographyType.paragraph,
                        // ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ),
          Center(
            child: TATypography.paragraph(
              text: title,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (icon != null)
            GestureDetector(
              onTap: onSecondaryActionTap,
              child: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 18),
                child: isIcon
                    ? Icon(
                        icon,
                        color: iconColor ?? Colors.black,
                      )
                    : TATypography.paragraph(
                        text: title,
                        fontWeight: FontWeight.bold,
                      ),
              ),
            )
        ],
      ),
    );
  }
}
