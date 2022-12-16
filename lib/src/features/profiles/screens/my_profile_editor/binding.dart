// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/profiles/screens/my_profile_editor/controller.dart';

class ProfileEditorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileEditorController>(() {
      return ProfileEditorController();
    });
  }
}
