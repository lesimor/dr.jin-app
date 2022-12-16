// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/products/screens/detail/controller.dart';

class ProductViewerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductViewerController>(() {
      return ProductViewerController();
    });
  }
}
