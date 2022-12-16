// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/common/widgets/cards/content.dart';
import 'package:bookrabbit/src/common/widgets/cards/content_resource.dart';
import 'package:bookrabbit/src/common/widgets/layout/appbar.dart';
import 'package:bookrabbit/src/common/widgets/loading.dart';
import 'package:bookrabbit/src/common/widgets/section.dart';
import 'package:bookrabbit/src/common/widgets/user_image.dart';
import 'package:bookrabbit/src/constants/size.dart';
import 'package:bookrabbit/src/features/authentication/controllers/auth_controller.dart';
import 'package:bookrabbit/src/features/entrypoint/screens/portal/controller.dart';
import 'package:bookrabbit/src/routing/routes.dart';
import 'package:bookrabbit/src/themes/custom_colors.dart';

class SizedMarginBox extends StatelessWidget {
  final double? height;
  const SizedMarginBox({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.white,
      child: SizedBox(
        height: this.height ?? 10.0,
      ),
    );
  }
}

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(HomePageController());
    var currentUser = AuthController.to.currentUser;
    var mediaQueryHeight = MediaQuery.of(context).size.height;
    // User의 목록을 가져온다.
    return Scaffold(
      backgroundColor: CustomColors.grayScale[100],
      appBar: appBarBuilder(
        context: context,
        preferredHeight: mediaQueryHeight * 0.05,
        backgroundColor: CustomColors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: COMMON_PADDING,
            ),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.MY_PROFILE);
              },
              child: ProfieImage(
                imageUrl: currentUser?.profileThumbnail,
                size: PROFILE_THUMBNAIL_LOGO_SIZE,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: controller.obx(
          (_) => ListView(
            children: [
              HomeSection(
                preText: '가장 주목받는',
                postText: '상담사',
                minHeight: mediaQueryHeight * 0.1,
                crossAxisCount: 3,
                childAspectRatio: RESOURCE_CARD_HEIGHT_WIDTH_ASPECT_RATIO,
                spacing: 20,
                pageName: AppRoutes.COUSELOR_LIST,
                cards: (controller.counselors ?? []).map<Widget>((r) {
                  return CounselorCard(couselor: r);
                }).toList(),
              ),
              HomeSection(
                preText: '상담컨텐츠',
                postText: '둘러보기',
                minHeight: MediaQuery.of(context).size.height * 0.15,
                crossAxisCount: 2,
                backgroundColor: CustomColors.grayScale[100],
                childAspectRatio: CLUB_CARD_HEIGHT_WIDTH_ASPECT_RATIO,
                spacing: 20,
                pageName: AppRoutes.CONTENT_LIST,
                cards: [
                  ...controller.contents
                      .map((elem) => ContentCard(content: elem))
                      .toList()
                ],
              ),
              // height 30px
            ],
          ),
          onLoading: Center(child: LoadingIndicator()),
        ),
      ),
    );
  }
}
