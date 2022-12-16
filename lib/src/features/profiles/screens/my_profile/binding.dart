// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/profiles/screens/my_profile/controller.dart';

class MyProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyProfileController>(() {
      return MyProfileController();
    });
  }
}
