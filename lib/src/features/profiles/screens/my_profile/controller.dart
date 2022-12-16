// Flutter imports:

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/authentication/data/user_respository.dart';

class MyProfileController extends GetxController with StateMixin {
  final UserRepository repository = UserRepository();

  @override
  void onInit() {
    change(null, status: RxStatus.loading());
    super.onInit();
    change(null, status: RxStatus.success());
  }

  @override
  void onClose() {
    super.onClose();
  }
}
