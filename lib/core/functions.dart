import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Open a link
Future<void> openLink(String link) async {
  final parsedLink = Uri.parse(link);
  if (await canLaunchUrl(parsedLink)) {
    await launchUrl(parsedLink, mode: LaunchMode.externalApplication);
  } else {
    debugPrint('No se pudo abrir el link.');
  }
}
