import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import '../../utils/colors.dart';
import '../typography/typography.dart';

class TAPrimaryInput extends StatefulWidget {
  const TAPrimaryInput({
    Key? key,
    required this.label,
    required this.placeholder,
    this.textEditingController,
    this.isPassword = false,
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final String placeholder;
  final String label;
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
