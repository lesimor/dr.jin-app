// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/entrypoint/screens/portal/controller.dart';
import 'package:bookrabbit/src/features/products/screens/detail/report/controller.dart';

class ReportPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReportPageController());
    Get.lazyPut(() => HomePageController());
  }
}
