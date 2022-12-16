// Dart imports:
import 'dart:io';

// Package imports:
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:bookrabbit/src/routing/routes.dart';

void routeKakaoWebview(String url) async {
  if (Platform.isIOS) {
    await launchUrl(Uri.parse(url));
    return;
  }

  Get.toNamed(
    AppRoutes.WEBVIEW,
    arguments: url,
  );
}
