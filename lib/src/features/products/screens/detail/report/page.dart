// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/common/widgets/toast.dart';
import 'package:bookrabbit/src/features/authentication/controllers/auth_controller.dart';
import 'package:bookrabbit/src/features/products/models/product.dart';
import 'package:bookrabbit/src/features/entrypoint/screens/portal/controller.dart';
import 'package:bookrabbit/src/features/products/screens/detail/report/controller.dart';
import 'package:bookrabbit/src/routing/routes.dart';
import 'package:bookrabbit/src/themes/app_theme.dart';
import 'package:bookrabbit/src/themes/custom_colors.dart';

class ReportPage extends GetView<ReportPageController> {
  final TextEditingController _textCon = TextEditingController();

  ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 필요한 내용 => 유저명, 유저아이디.
    String userName = Get.arguments['userName'];
    int userId = Get.arguments['userId'];

    ReportType reportMode = Get.arguments['reportType'];
    controller.reportType = reportMode;
    ProductDetailModel? product = Get.arguments['product'];

    // 유저 정보 받아오기
    HomePageController homeController = Get.find<HomePageController>();
    AuthController authController = Get.find<AuthController>();
    // User의 목록을 가져온다.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.page,
        elevation: 0,
        title: Text(
          '신고하기',
          style: textTheme.subtitle2!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              '신고 사유',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            controller: _textCon,
            style: TextStyle(
              fontSize: 16,
            ),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: CustomColors.primaryGreen,
                ),
              ),
              border: OutlineInputBorder(),
              hintText: '신고 사유를 간략하게 입력해주세요',
            ),
            minLines: 3,
            maxLines: 3,
          ),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => GestureDetector(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  controller.checked
                      ? Icon(
                          Icons.check_circle,
                          color: CustomColors.primaryGreen,
                        )
                      : Icon(
                          Icons.circle_outlined,
                          color: CustomColors.primaryGreen,
                        ),
                  Text(
                    '${userName}님 차단하기',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: controller.checked
                          ? CustomColors.primaryGreen
                          : CustomColors.grayScale[600],
                    ),
                  ),
                ],
              ),
              onTap: () {
                controller.checked = !controller.checked;
              },
            ),
          ),
          Text(
            '차단하면 상대방이 진행하는 모임 정보를 더 이상 볼 수 없으며, 상대방도 나의 정보를 볼 수 없습니다.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: CustomColors.grayScale[600],
            ),
          ),
          Text(
            '상대방에게는 차단했다는 정보를 알리지 않습니다.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: CustomColors.grayScale[600],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          OutlinedButton(
            onPressed: () {
              // 신고 내용 전송
              if (_textCon.text.isNotEmpty) {
                String content = '';
                if (controller.reportType == ReportType.product) {
                  content =
                      '모임 신고(${product?.title} / id: ${product?.id}): ${_textCon.text}';
                } else if (controller.reportType == ReportType.user) {
                  content = '유저 신고: ${_textCon.text}';
                }
                controller.reportUser(userId, content);
              }

              // 사용자 차단
              if (controller.checked) {
                controller.blockUser(userId);
              }

              // 컨텐츠 리로드
              homeController.getData();

              // 사용자정보 리로드
              authController.initCurrentUser();

              // 얼러트 띄워주기
              showToast(message: '신고 접수가 완료되었습니다.');

              // 메인으로 이동
              Get.offAllNamed(AppRoutes.INITIAL_PAGE);
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: CustomColors.primaryGreen,
            ),
            child: Center(
              child: Text(
                '신고하기',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: CustomColors.white,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
