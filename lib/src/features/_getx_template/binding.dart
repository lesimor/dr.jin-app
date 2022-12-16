// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/_getx_template/controller.dart';

class ModuleTemplateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TemplatePageController>(() {
      return TemplatePageController();
    });
  }
}
