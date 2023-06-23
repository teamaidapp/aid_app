import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/entities/dropdown.model.dart';
import 'package:team_aid/design_system/design_system.dart';

/// This widget makes a http request to google api to get the location
class LocationWidget extends HookWidget {
  /// Constructor
  const LocationWidget({
    required this.onChanged,
    super.key,
  });

  /// The callback that is called when the dropdown changes.
  final void Function(TADropdownModel?) onChanged;

  @override
  Widget build(BuildContext context) {
    final name = useTextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TATypography.paragraph(
          text: 'Location',
          fontWeight: FontWeight.w500,
          color: TAColors.color1,
        ),
        SizedBox(height: 0.5.h),
        DropdownSearch<TADropdownModel>(
          asyncItems: (filter) async {
            final url =
                'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${name.text}&key=${dotenv.env['GOOGLE_API_KEY']}';
            final response = await http.get(Uri.parse(url));

            final list = <TADropdownModel>[];

            if (response.statusCode == 200) {
              final data =
                  (jsonDecode(response.body) as Map)['predictions'] as List;
              for (final place in data) {
                final taDropdownModel = TADropdownModel(
                  item: (place as Map)['description'] as String,
                  id: place['place_id'] as String,
                );
                list.add(taDropdownModel);
              }
              return list;
            } else {
              return [];
            }
          },
          onChanged: onChanged,
          itemAsString: (item) => item.item,
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
              hintText: '',
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
          popupProps: PopupProps.bottomSheet(
            fit: FlexFit.loose,
            showSearchBox: true,
            isFilterOnline: true,
            searchFieldProps: TextFieldProps(
              controller: name,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: InputDecoration(
                hintText: '',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                label: TATypography.paragraph(
                  text: 'Search a place',
                  fontWeight: FontWeight.w500,
                  color: TAColors.color1,
                ),
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
          ),
        ),
      ],
    );
  }
}
