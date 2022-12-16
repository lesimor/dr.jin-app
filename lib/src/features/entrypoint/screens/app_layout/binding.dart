// Package imports:
import 'package:bookrabbit/src/features/entrypoint/screens/app_layout/controller.dart';
import 'package:bookrabbit/src/features/matches/screens/chat_list/controller.dart';
import 'package:bookrabbit/src/features/matches/screens/chatroom/controller.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/entrypoint/screens/portal/controller.dart';
import 'package:bookrabbit/src/features/settings/screens/app_setting/controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RootController());
    Get.lazyPut(() => HomePageController());
    // NOTE: tmp
    Get.lazyPut(() => ChatroomPageController());
    Get.lazyPut(() => ChatListPageController());
    Get.lazyPut(() => SettingController());
  }
}
