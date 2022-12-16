// Flutter imports:
import 'package:bookrabbit/src/common/widgets/buttons/button.dart';
import 'package:bookrabbit/src/common/widgets/intput.dart';
import 'package:bookrabbit/src/common/widgets/layout/appbar.dart';
import 'package:bookrabbit/src/common/widgets/toast.dart';
import 'package:bookrabbit/src/features/authentication/controllers/auth_controller.dart';
import 'package:bookrabbit/src/features/entrypoint/screens/app_layout/controller.dart';
import 'package:bookrabbit/src/themes/custom_colors.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/matches/screens/chatroom/controller.dart';

const double BOTTOM_SHEET_HEIGHT = 90.0;
const EdgeInsets BOTTOM_SHEET_PADDING = EdgeInsets.only(
  bottom: BOTTOM_SHEET_HEIGHT,
);

class ChatroomPage extends GetView<ChatroomPageController> {
  const ChatroomPage({super.key});

  @override
  Widget build(BuildContext context) {
    var currentUser = AuthController.to.currentUser;
    // User의 목록을 가져온다.
    return GetBuilder<ChatroomPageController>(
      init: ChatroomPageController(),
      initState: (_) {
        controller.channelId = Get.arguments['channelId'];
        controller.reservation = Get.arguments['reservation'];
      },
      builder: (_) {
        var rootController = Get.find<RootController>();
        return Scaffold(
          appBar: appBarBuilder(
            context: context,
            titleText: controller.reservation?.content.title,
            actions: [
              // 취소 아이콘
              GestureDetector(
                onTap: () async {
                  await _.cancelReservation(controller.reservation.uid);
                  await rootController.fetchReservations();
                  rootController.tabIndex = 1;
                  showToast(
                    message: '상담이 취소되었습니다.',
                  );
                  Get.back();
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(Icons.cancel_outlined),
                  ),
                ),
              )
            ],
          ),
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Stack(
              children: [
                StreamBuilder(
                  stream: controller.channel!.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      controller.fetchMessages(controller.channelId);
                    }
                    return StreamBuilder(
                      stream: controller.streamController.stream,
                      builder: (context, snapshot) {
                        return ListView(
                          // width: double.infinity,
                          children: [
                            ...(snapshot.data != null
                                    ? snapshot.data as List
                                    : [])
                                .map(
                              (message) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 4,
                                ),
                                child: Align(
                                  alignment: message.senderId == currentUser?.id
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: message.senderId == currentUser?.id
                                          ? Colors.blue
                                          : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Text(
                                        message.content,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                Positioned(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: TransparentTextField(
                            focusNode: controller.textInputFocus,
                            controller: controller.textInputController,
                            scrollPadding: BOTTOM_SHEET_PADDING,
                          ),
                        ),
                        Container(
                          width: 100,
                          child: ActionButton(
                            onPressed: () {
                              controller.sendMessage(
                                controller.textInputController.text,
                              );
                              controller.textInputController.clear();
                            },
                            buttonText: '전송',
                          ),
                        ),
                      ],
                    ),
                    decoration:
                        BoxDecoration(color: CustomColors.grayScale[200]),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
