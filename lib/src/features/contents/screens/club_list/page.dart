// Flutter imports:
import 'package:bookrabbit/src/common/widgets/cards/content.dart';
import 'package:bookrabbit/src/constants/size.dart';
import 'package:bookrabbit/src/features/contents/screens/club_list/controller.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/common/widgets/layout/appbar.dart';
import 'package:bookrabbit/src/common/widgets/loading.dart';
import 'package:bookrabbit/src/themes/custom_colors.dart';

class ClubListPage extends GetView<ClubListPageController> {
  const ClubListPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ClubListPageController());
    return Scaffold(
      appBar: appBarBuilder(
        context: context,
        titleText: '상담컨텐츠 둘러보기',
      ),
      body: SafeArea(
        child: controller.obx(
          (_) => Container(
            color: CustomColors.page,
            child: GridView.count(
              padding: const EdgeInsets.all(COMMON_PADDING),
              crossAxisCount: 2,
              childAspectRatio: 0.9,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                ...(controller.contentList.map<Widget>((content) {
                  return ContentCard(content: content);
                }).toList()),
              ],
            ),
          ),
          onLoading: Center(child: LoadingIndicator()),
        ),
      ),
    );
  }
}
