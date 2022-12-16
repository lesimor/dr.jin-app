// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/authentication/controllers/auth_controller.dart';
import 'package:bookrabbit/src/features/authentication/screens/registration/controller.dart';

class RegistrationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationController>(() {
      return RegistrationController();
    });
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
