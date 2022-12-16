// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/profiles/screens/user_profile/controller.dart';

class UserProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProfileController>(() {
      return UserProfileController();
    });
  }
}
