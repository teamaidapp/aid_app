import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/entities/dropdown.model.dart';
import 'package:team_aid/design_system/components/typography/typography.dart';
import 'package:team_aid/design_system/utils/colors.dart';

/// A callback that is called when the dropdown changes.
typedef DropdownChangeCallback = void Function(
  List<TADropdownModel> selectedValue,
);

/// The TAPrimaryInput class is a stateful widget that creates a text input
/// field with a label, placeholder, and optional password visibility toggle.
class TAMultiDropdown extends StatefulWidget {
  /// Constructor
  const TAMultiDropdown({
    required this.label,
    required this.items,
    required this.placeholder,
    required this.onChange,
    this.isPassword = false,
    this.selectedValues = const [],
    super.key,
  });

  /// The placeholder text for the text field.
  final String placeholder;

  /// The label text for the text field.
  final String label;

  /// The list of items for the dropdown.
  final List<TADropdownModel> items;

  /// A boolean that is used to determine if the text field is a password field.
  final bool isPassword;

  /// A callback that is called when the dropdown changes.
  final DropdownChangeCallback onChange;

  /// The selected value of the dropdown.
  final List<TADropdownModel> selectedValues;

  @override
  State<TAMultiDropdown> createState() => _TAMultiDropdownState();
}

class _TAMultiDropdownState extends State<TAMultiDropdown> {
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
        DropdownSearch<TADropdownModel>.multiSelection(
          items: List.generate(
            widget.items.length,
            (index) => widget.items[index],
          ),
          selectedItems: widget.selectedValues,
          itemAsString: (item) => item.item,
          onChanged: widget.onChange,
          dropdownButtonProps: const DropdownButtonProps(
            icon: Icon(
              Iconsax.arrow_down_1,
              size: 14,
              color: Colors.black,
            ),
          ),
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: TAColors.color2,
            ),
            dropdownSearchDecoration: InputDecoration(
              hintText: widget.placeholder,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: TAColors.color1.withOpacity(0.5),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: TAColors.color1.withOpacity(0.5),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: TAColors.color1,
                ),
              ),
              hintStyle: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: TAColors.color2,
              ),
            ),
          ),
          popupProps: PopupPropsMultiSelection.menu(
            fit: FlexFit.loose,
            constraints: const BoxConstraints.tightFor(),
            menuProps: MenuProps(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        )
      ],
    );
  }
}
