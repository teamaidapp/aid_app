import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/design_system/components/typography/typography.dart';
import 'package:team_aid/design_system/utils/colors.dart';

/// The TAPrimaryInput class is a stateful widget that creates a text input
/// field with a label, placeholder, and optional password visibility toggle.
class TADropdown extends StatefulWidget {
  /// Constructor
  const TADropdown({
    required this.label,
    required this.placeholder,
    required this.items,
    super.key,
    this.textEditingController,
    this.isPassword = false,
  });

  /// The controller for the text field.
  final TextEditingController? textEditingController;

  /// The placeholder text for the text field.
  final String placeholder;

  /// The label text for the text field.
  final String label;

  /// The list of items for the dropdown.
  final List<String> items;

  /// A boolean that is used to determine if the text field is a password field.
  final bool isPassword;

  @override
  State<TADropdown> createState() => _TADropdownState();
}

class _TADropdownState extends State<TADropdown> {
  late TextEditingController textEditingController = widget.textEditingController ?? TextEditingController();
  bool obscureText = true;
  bool isPassword = false;
  @override
  void initState() {
    isPassword = obscureText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TATypography.paragraph(
          text: widget.label,
          fontWeight: FontWeight.w500,
          color: TAColors.color1,
        ),
        SizedBox(height: 0.5.h),
        CustomDropdown(
          items: widget.items,
          hintStyle: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: TAColors.color2,
          ),
          hintText: widget.placeholder,
          borderSide: BorderSide(
            color: TAColors.color1.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(10),
          controller: textEditingController,
        ),
      ],
    );
  }
}
