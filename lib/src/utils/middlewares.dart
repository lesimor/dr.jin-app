// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/authentication/controllers/auth_controller.dart';
import 'package:bookrabbit/src/routing/routes.dart';

class AuthenticationRequired extends GetMiddleware {
  final authController = Get.find<AuthController>();

  @override
  RouteSettings? redirect(String? route) {
    // 로그인 상태가 아니면 로그인 페이지로 이동
    return authController.isAuthenticatedUser
        ? null
        : RouteSettings(name: AppRoutes.LOGIN_WITH_EMAIL);
  }
}

