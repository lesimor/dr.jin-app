// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/authentication/controllers/auth_controller.dart';
import 'package:bookrabbit/src/features/authentication/screens/login_main/controller.dart';

class UserBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModelTemplateController>(() {
      return ModelTemplateController();
    });
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
