// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

// Project imports:
import 'package:bookrabbit/environment.dart';
import 'package:bookrabbit/firebase_options.dart';
import 'package:bookrabbit/src/features/authentication/controllers/auth_controller.dart';
import 'package:bookrabbit/src/features/entrypoint/screens/app_layout/binding.dart';
import 'package:bookrabbit/src/routing/pages.dart';
import 'package:bookrabbit/src/routing/routes.dart';
import 'package:bookrabbit/src/themes/app_theme.dart';
import 'package:bookrabbit/src/utils/dynamic_link.dart';

void main() async {
  // config 초기화
  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.DEV,
  );
  Environment().initConfig(environment);

  // 안정적인 플러그인 동작을 보장하기 위한 위젯 바인딩
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Firebase init
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 인증정보를 가져와서 사용자 정보를 초기화.
  var authController = Get.put(AuthController());
  await authController.initCurrentUser();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(BookRabbitApplication());

  FlutterNativeSplash.remove();
}

class BookRabbitApplication extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    // DynamicLink Listener
    DynamicLink().setup();

    return GetMaterialApp(
      navigatorKey: Get.key,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.INITIAL_PAGE,
      initialBinding: InitialBinding(),
      getPages: AppPages.pages,
      theme: appThemeData,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ko', ''),
        Locale('en', ''),
      ],
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      // defaultTransition: Transition.fade,
    );
  }
}
