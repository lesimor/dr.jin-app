// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/common/widgets/buttons/button.dart';
import 'package:bookrabbit/src/common/widgets/layout/appbar.dart';
import 'package:bookrabbit/src/common/widgets/layout/bottomsheet.dart';
import 'package:bookrabbit/src/common/widgets/loading.dart';
import 'package:bookrabbit/src/common/widgets/toast.dart';
import 'package:bookrabbit/src/features/authentication/controllers/auth_controller.dart';
import 'package:bookrabbit/src/features/profiles/screens/my_profile_editor/controller.dart';
import 'package:bookrabbit/src/common/widgets/forms/profile_input.dart';
import 'package:bookrabbit/src/themes/custom_colors.dart';

class ProfileEditorPage extends GetView<ProfileEditorController> {
  // final TextEditingController _nicknameCon = TextEditingController();

  ProfileEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    // User의 목록을 가져온다.
    return Scaffold(
      appBar: appBarBuilder(context: context, titleText: '프로필 설정'),
      bottomSheet: BottomSheetForButtonArea(
        context: context,
        widget: ActionButton(
          buttonText: '저장',
          onPressed: () async {
            // TODO: 수정된 필드만 업데이트하기.
            await controller.changeUserInfo();
            AuthController.to.initCurrentUser();
            showToast(message: '프로필 수정이 완료되었습니다.');
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30.0,
              horizontal: 30.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    controller.imageUrl =
                        await ProfileEditorController.to.pickImage();
                  },
                  child: CircleAvatar(
                    radius: 34,
                    backgroundColor: CustomColors.grayScale[200],
                    child: controller.obx(
                      (_) => controller.imageUrl == null
                          ? SvgPicture.asset(
                              'assets/icon/common/rabbit.svg',
                              width: 30,
                              color: CustomColors.white,
                            )
                          : ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: controller.imageUrl,
                              ),
                            ),
                      onLoading: LoadingIndicator(),
                    ),
                  ),
                ),
                ProfileFieldInput(
                  placeHolder: '닉네임',
                  formController: ProfileEditorController.to.nicknameCon,
                  widgetController: controller,
                  maxLength: 5,
                  maxLines: 1,
                ),
                ProfileFieldInput(
                  placeHolder: '한줄소개',
                  formController: ProfileEditorController.to.introductionCon,
                  widgetController: controller,
                  maxLength: 25,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
