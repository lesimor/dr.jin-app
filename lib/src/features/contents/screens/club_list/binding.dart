// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/contents/screens/club_list/controller.dart';

class ClubListPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClubListPageController>(() {
      return ClubListPageController();
    });
  }
}
