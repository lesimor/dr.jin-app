// Flutter imports:
import 'package:bookrabbit/src/common/widgets/chat/chatroom.dart';
import 'package:bookrabbit/src/common/widgets/layout/appbar.dart';
import 'package:bookrabbit/src/features/entrypoint/screens/app_layout/controller.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:

class ChatListPage extends GetView<RootController> {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // User의 목록을 가져온다.
    return Scaffold(
      appBar: appBarBuilder(
        context: context,
        titleText: '대화목록',
      ),
      body: SafeArea(
        child: controller.obx(
          (_) => ListView(
            children: [
              ...controller.reservations
                  .map((reservation) => Chatroom(reservation: reservation))
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}
