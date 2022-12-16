// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/profiles/screens/profile_list/controller.dart';

class ProfileListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileListController>(() {
      return ProfileListController();
    });
  }
}
