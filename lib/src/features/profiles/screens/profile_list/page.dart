// Flutter imports:
import 'package:bookrabbit/src/common/widgets/cards/content_resource.dart';
import 'package:bookrabbit/src/common/widgets/loading.dart';
import 'package:bookrabbit/src/constants/size.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/common/widgets/layout/appbar.dart';
import 'package:bookrabbit/src/features/profiles/screens/profile_list/controller.dart';
import 'package:bookrabbit/src/themes/custom_colors.dart';

class ProfileListPage extends GetView<ProfileListController> {
  const ProfileListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBuilder(
        context: context,
        titleText: '상담사 찾기',
      ),
      body: SafeArea(
        child: controller.obx(
          (_) => Container(
            color: CustomColors.page,
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: RESOURCE_CARD_HEIGHT_WIDTH_ASPECT_RATIO,
              padding: const EdgeInsets.all(COMMON_PADDING),
              shrinkWrap: true,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: (controller.counselors ?? []).map<Widget>((r) {
                return CounselorCard(couselor: r);
              }).toList(),
            ),
          ),
          onLoading: Center(
            child: LoadingIndicator(),
          ),
        ),
      ),
    );
  }
}
