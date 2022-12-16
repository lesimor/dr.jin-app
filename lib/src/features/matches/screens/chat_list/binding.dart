// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/matches/screens/chat_list/controller.dart';

class ChatListPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatListPageController>(() {
      return ChatListPageController();
    });
  }
}
