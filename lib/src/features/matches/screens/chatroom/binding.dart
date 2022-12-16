// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/matches/screens/chatroom/controller.dart';

class ChatroomPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatroomPageController>(() {
      return ChatroomPageController();
    });
  }
}
