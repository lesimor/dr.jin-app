// Dart imports:
import 'dart:io';

// Flutter imports:
import "package:flutter/material.dart";
import 'package:flutter/services.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Project imports:
import 'package:bookrabbit/src/utils/logger.dart';

class ServiceCenterWebviewPage extends GetView {
  static const platform = MethodChannel('default_channel');

  const ServiceCenterWebviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: Get.arguments,
      javascriptMode: JavascriptMode.unrestricted,
      navigationDelegate: (request) async {
        logger.d('navigate url : ${request.url}');

        // 2 채널이용
        if (!request.url.startsWith('http') &&
            !request.url.startsWith('https')) {
          if (Platform.isAndroid) {
            getAppUrl(request.url.toString());

            return NavigationDecision.prevent;
          } else if (Platform.isIOS) {
            if (await canLaunchUrl(Uri.parse(request.url))) {
              logger.d('navigate url : ${request.url}');

              await launchUrl(
                Uri.parse(request.url),
              );

              return NavigationDecision.prevent;
            }
          }
        }

        return NavigationDecision.navigate;
      },
    );
  }

  Future getAppUrl(String url) async {
    await platform.invokeMethod('getAppUrl', <String, Object>{'url': url}).then(
        (value) async {
      logger.d('paring url : $value');

      // 추가 채널 메서드 정의 예시
      // if (value.toString().startsWith('ispmobile://')) {
      //   await platform.invokeMethod(
      //     'startAct',
      //     <String, Object>{'url': url},
      //   ).then((value) {
      //     logger.d('parsing url : $value');

      //     return;
      //   });
      // }

      if (await canLaunchUrl(Uri.parse(value))) {
        await launchUrl(
          Uri.parse(value),
        );

        return;
      } else {
        logger.d('해당 앱이 설치되어 있지 않습니다.');
        return;
      }
    });
  }
}
