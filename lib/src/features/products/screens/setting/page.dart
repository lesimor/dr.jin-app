// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/common/widgets/alert.dart';
import 'package:bookrabbit/src/common/widgets/layout/appbar.dart';
import 'package:bookrabbit/src/common/widgets/toast.dart';
import 'package:bookrabbit/src/features/authentication/controllers/auth_controller.dart';
import 'package:bookrabbit/src/features/products/screens/detail/controller.dart';
import 'package:bookrabbit/src/routing/routes.dart';
import 'package:bookrabbit/src/themes/app_theme.dart';
import 'package:bookrabbit/src/themes/custom_colors.dart';

class ListViewDividerWidget extends StatelessWidget {
  const ListViewDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.0,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: CustomColors.grayScale[100],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 14, color: CustomColors.grayScale[600]),
      ),
      visualDensity: VisualDensity(vertical: -4),
    );
  }
}

class ProductSettingPage extends GetView<ProductViewerController> {
  const ProductSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // var controller = Get.find<ProductSettingController>();
    // controller.product = Get.arguments['product'];
    return Scaffold(
      appBar: appBarBuilder(
        context: context,
        titleText: '모임 설정',
        backgroundColor: CustomColors.grayScale[100]!,
      ),
      body: GetBuilder<ProductViewerController>(
        init: ProductViewerController(),
        builder: (_) {
          return ListView(
            children: <Widget>[
              SectionTitle(title: '모임 정보'),
              ListTile(
                title: Text('모임 수정하기', style: textTheme.bodyText2),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.toNamed(
                    AppRoutes.BOOKDAY_EDITOR,
                    arguments: {
                      "product": _.product,
                    },
                  );
                },
              ),
              ListViewDividerWidget(),
              SectionTitle(title: '모임 운영'),
              ListTile(
                title: Text('멤버 관리', style: textTheme.bodyText2),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.toNamed(AppRoutes.PRODUCT_MEMBER_MANAGER);
                },
              ),
              GestureDetector(
                onTap: () {
                  showCustomAlert(
                    context: context,
                    title: '모임을 삭제하시겠어요?',
                    onConfirm: () async {
                      await _.deleteProduct();

                      // 내 정보 동기화
                      Get.find<AuthController>().initCurrentUser();

                      showToast(message: '모임이 삭제되었습니다.');
                      Get.offAllNamed(AppRoutes.INITIAL_PAGE);
                    },
                  );
                },
                child: ListTile(
                  title: Text('모임 삭제', style: textTheme.bodyText2),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
