import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' show get;
import 'package:iconsax/iconsax.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:team_aid/design_system/components/appbar/appbar.dart';
import 'package:team_aid/design_system/utils/colors.dart';

/// The statelessWidget that handles the current screen
class ViewFileScreen extends HookWidget {
  /// The constructor.
  const ViewFileScreen({
    required this.url,
    super.key,
  });

  /// The url of the file to be viewed
  final String url;

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    return Scaffold(
      appBar: TAAppBar.build(
        context,
        backgroundColor: Colors.black,
        iconColor: Colors.white,
        icon: Iconsax.share,
        onSecondaryActionTap: () async {
          isLoading.value = true;
          final response = await get(Uri.parse(url));
          final directory = await getTemporaryDirectory();
          isLoading.value = false;
          final file = await File('${directory.path}/Image.png').writeAsBytes(response.bodyBytes);
          final result = await Share.shareXFiles([XFile(file.path)], text: 'Share');

          if (result.status == ShareResultStatus.success) {
            debugPrint('Thank you for sharing the picture!');
          }
        },
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          PhotoView(
            imageProvider: NetworkImage(url),
            enableRotation: true,
          ),
          if (isLoading.value)
            Center(
              child: SizedBox(
                height: 100.h,
                width: 100.w,
                child: ColoredBox(
                  color: Colors.black.withOpacity(0.8),
                  child: const SizedBox(
                    height: 50,
                    width: 50,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: TAColors.purple,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
