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
  });

  /// The controller for the text field.
  final TextEditingController? textEditingController;

  /// The placeholder text for the text field.
  final String placeholder;

  /// The label text for the text field.
  final String label;

  /// A boolean that is used to determine if the text field is a password field.
  final bool isPassword;

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
          color: TAColors.primary,
        ),
        SizedBox(height: 0.5.h),
        TextFormField(
          cursorColor: TAColors.primary,
          controller: textEditingController,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromRGBO(196, 196, 196, 0.2),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelStyle: GoogleFonts.poppins(
              color: TAColors.primary,
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
                      color: TAColors.primary,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
