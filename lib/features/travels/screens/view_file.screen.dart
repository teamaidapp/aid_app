import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:team_aid/design_system/components/appbar/appbar.dart';

/// The statelessWidget that handles the current screen
class ViewFileScreen extends StatelessWidget {
  /// The constructor.
  const ViewFileScreen({
    required this.url,
    super.key,
  });

  /// The url of the file to be viewed
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAAppBar.build(
        context,
        backgroundColor: Colors.black,
        iconColor: Colors.white,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: PhotoView(
        imageProvider: NetworkImage(url),
        enableRotation: true,
      ),
    );
  }
}
