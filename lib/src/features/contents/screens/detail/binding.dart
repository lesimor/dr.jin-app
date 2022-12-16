// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/contents/screens/detail/controller.dart';

class ClubDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContentDetailPageController>(() {
      return ContentDetailPageController();
    });
  }
}
