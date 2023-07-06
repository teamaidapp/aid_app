import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/design_system/components/typography/typography.dart';
import 'package:team_aid/design_system/utils/colors.dart';

/// The TAPrimaryInput class is a stateful widget that creates a text input
/// field with a label, placeholder, and optional password visibility toggle.
class TAPrimaryInput extends StatefulWidget {
  /// Constructor
  const TAPrimaryInput({
    required this.label,
    required this.placeholder,
    super.key,
    this.textEditingController,
    this.isPassword = false,
    this.maxLines,
  });

  /// The controller for the text field.
  final TextEditingController? textEditingController;

  /// The placeholder text for the text field.
  final String placeholder;

  /// The label text for the text field.
  final String label;

  /// A boolean that is used to determine if the text field is a password field.
  final bool isPassword;

  /// The maximum number of lines for the text field.
  final int? maxLines;

  @override
  State<TAPrimaryInput> createState() => _TAPrimaryInputState();
}

class _TAPrimaryInputState extends State<TAPrimaryInput> {
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
        TextFormField(
          cursorColor: TAColors.color2,
          controller: textEditingController,
          obscureText: obscureText,
          // maxLines: widget.maxLines,
          decoration: InputDecoration(
            filled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 1.5.h),
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: TAColors.color1.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelStyle: GoogleFonts.poppins(
              color: TAColors.color1,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: TAColors.color1.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: widget.placeholder,
            suffixIcon: isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    icon: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off,
                      color: TAColors.color1,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
