import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/design_system/design_system.dart';

/// The Time Picker of Team Aid
class TATimePicker extends StatefulWidget {
  /// Constructor
  const TATimePicker({
    required this.label,
    required this.onChanged,
    required this.pickedDate,
    this.hourFrom,
    this.cupertinoDatePickerMode = CupertinoDatePickerMode.time,
    super.key,
  });

  /// The label of the picker
  final String label;

  /// The picked date
  final DateTime? pickedDate;

  /// The hour from
  final int? hourFrom;

  /// Cupertino date picker mode
  final CupertinoDatePickerMode cupertinoDatePickerMode;

  /// Triggers when the picker changes
  final Function(DateTime) onChanged;

  @override
  State<TATimePicker> createState() => _TATimePickerState();
}

class _TATimePickerState extends State<TATimePicker> {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return GestureDetector(
      onTap: () {
        DateTime dateTime;
        if (widget.pickedDate != null) {
          dateTime = widget.pickedDate!;
        } else {
          if (widget.cupertinoDatePickerMode == CupertinoDatePickerMode.time) {
            dateTime = DateTime(now.year, now.month, now.day, widget.hourFrom ?? now.hour, 30);
          } else {
            dateTime = DateTime(now.year, now.month, now.day, now.hour);
          }
        }
        widget.onChanged(dateTime);
        showCupertinoModalPopup<void>(
          context: context,
          builder: (_) => Container(
            height: 500,
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Column(
              children: [
                SizedBox(
                  height: 400,
                  child: CupertinoDatePicker(
                    mode: widget.cupertinoDatePickerMode,
                    initialDateTime: dateTime,
                    onDateTimeChanged: widget.onChanged,
                  ),
                ),
                CupertinoButton(
                  child: const Text('Close'),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TATypography.paragraph(
            text: widget.label,
            fontWeight: FontWeight.w500,
            color: TAColors.color1,
          ),
          SizedBox(height: 0.5.h),
          // OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(10),
          //       borderSide: BorderSide(
          //         color: TAColors.color1.withOpacity(0.5),
          //       ),
          //     ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: TAColors.color1.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 48,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.centerLeft,
            child: widget.pickedDate != null
                ? TATypography.paragraph(
                    text: calculateLabel,
                    color: TAColors.color2,
                    fontWeight: FontWeight.w600,
                  )
                : TATypography.paragraph(
                    text: 'Select a time',
                    color: TAColors.color2,
                    fontWeight: FontWeight.w600,
                  ),
          ),
        ],
      ),
    );
  }

  String get calculateLabel {
    if (widget.pickedDate == null) {
      return '';
    }

    if (widget.cupertinoDatePickerMode == CupertinoDatePickerMode.time) {
      var hour = widget.pickedDate!.hour;
      final minute = widget.pickedDate!.minute;

      final amPm = hour < 12 ? 'AM' : 'PM';

      hour = hour % 12; // Convert to 12-hour format

      if (hour == 0) {
        hour = 12; // Display 12 instead of 0 at 12:00 AM or 12:00 PM
      }

      final formattedHour = hour.toString().padLeft(2, '0');
      final formattedMinute = minute.toString().padLeft(2, '0');

      return '$formattedHour:$formattedMinute $amPm';
    } else {
      return DateFormat.MMMEd().format(widget.pickedDate!);
    }
  }
}
