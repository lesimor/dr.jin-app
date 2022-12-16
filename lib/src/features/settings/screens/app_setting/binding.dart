// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/settings/screens/app_setting/controller.dart';

class SettingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() {
      return SettingController();
    });
  }
}
