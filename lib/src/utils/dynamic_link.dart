// Package imports:
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';

// Project imports:
import 'package:bookrabbit/src/routing/routes.dart';
import 'package:bookrabbit/src/utils/logger.dart';

class DynamicLink {
  static const PREFIX = 'https://bkrb.page.link';
  // commands
  static const REDIRECT = "redirect";

  Future<bool> setup() async {
    bool isExistDynamicLink = await _getInitialDynamicLink();
    _addListener();

    return isExistDynamicLink;
  }

  Future<bool> _getInitialDynamicLink() async {
    final String? deepLink = await getInitialLink();

    if (deepLink != null) {
      PendingDynamicLinkData? dynamicLinkData = await FirebaseDynamicLinks
          .instance
          .getDynamicLink(Uri.parse(deepLink));

      if (dynamicLinkData != null) {
        redirectScreen(dynamicLinkData);

        return true;
      }
    }

    return false;
  }

  void _addListener() {
    FirebaseDynamicLinks.instance.onLink.listen((
      PendingDynamicLinkData dynamicLinkData,
    ) {
      redirectScreen(dynamicLinkData);
    }).onError((error) {
      logger.e(error);
    });
  }

  void redirectScreen(PendingDynamicLinkData dynamicLinkData) {
    String command = dynamicLinkData.link.path.split("/").last;
    Map<String, String> params = dynamicLinkData.link.queryParameters;

    if (command == DynamicLink.REDIRECT && params.containsKey("path")) {
      String path = params["path"]!;

      switch (path) {
        case AppRoutes.PRODUCT_VIEWER:
          if (params.containsKey("id")) {
            String id = params["id"]!;
            Get.toNamed(path, arguments: {"productId": int.parse(id)});
          }
          break;
      }
    }
  }
}

Future<String> getShortLink(
  String command,
  String screenName,
  String id,
) async {
  Uri iosFallback = Uri.parse(
    'https://apps.apple.com/kr/app/%EB%B6%81%EB%9E%98%EB%B9%97/id1637196054',
  );
  Uri androidFallback = Uri.parse(
    'https://play.google.com/store/apps/details?id=com.dchainconnect.bookrabbit',
  );

  final dynamicLinkParams = DynamicLinkParameters(
    uriPrefix: DynamicLink.PREFIX,
    link: Uri.parse('${DynamicLink.PREFIX}/$command?path=$screenName&id=$id'),
    androidParameters: AndroidParameters(
      packageName: "com.dchainconnect.bookrabbit",
      minimumVersion: 27,
      fallbackUrl: androidFallback,
    ),
    iosParameters: IOSParameters(
      appStoreId: "1637196054",
      bundleId: "com.dchainconnect.bookrabbit",
      minimumVersion: '1.1.0',
      fallbackUrl: iosFallback,
    ),
  );
  final dynamicLink =
      await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

  return dynamicLink.shortUrl.toString();
}
