// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/entrypoint/screens/portal/controller.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePageController>(() {
      return HomePageController();
    });
  }
}
