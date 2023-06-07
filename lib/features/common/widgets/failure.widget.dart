import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/design_system/design_system.dart';

/// The success widget
class FailureWidget {
  /// Build the success widget
  static Future<void> build({
    required String title,
    required String message,
    required BuildContext context,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xffE26EA5),
      barrierColor: Colors.white.withOpacity(0.8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      builder: (context) {
        return SizedBox(
          height: 40.h,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                Align(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Iconsax.dislike,
                        color: Colors.white,
                        size: 40,
                      ),
                      SizedBox(height: 2.h),
                      TATypography.h3(
                        text: title,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: 2.h),
                      TATypography.paragraph(
                        text: message,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 20,
                  child: GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child:
                        const Icon(Iconsax.close_circle, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
