// Flutter imports:
import 'package:bookrabbit/src/common/widgets/buttons/button.dart';
import 'package:bookrabbit/src/common/widgets/layout/appbar.dart';
import 'package:bookrabbit/src/common/widgets/loading.dart';
import 'package:bookrabbit/src/common/widgets/toast.dart';
import 'package:bookrabbit/src/constants/size.dart';
import 'package:bookrabbit/src/features/authentication/models/user.dart';
import 'package:bookrabbit/src/features/entrypoint/screens/app_layout/controller.dart';
import 'package:bookrabbit/src/themes/custom_colors.dart';
import 'package:bookrabbit/src/utils/image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/contents/screens/detail/controller.dart';

const TAB_COUNT = 4;
const AVATOR_WIDTH = 30.0;

class ContentDetailpage extends GetView<ContentDetailPageController> {
  const ContentDetailpage({super.key});

  @override
  Widget build(BuildContext context) {
    var rootController = Get.find<RootController>();
    // User의 목록을 가져온다.
    return GetBuilder<ContentDetailPageController>(
      init: ContentDetailPageController(),
      initState: (_) {
        controller.contentId = Get.arguments['contentId'];
      },
      builder: (_) {
        UserOutModel? creator = controller.content?.creator;
        return Scaffold(
          appBar: appBarBuilder(
            context: context,
            titleText: '컨텐츠',
          ),
          body: SafeArea(
            child: controller.obx(
              (_) => SingleChildScrollView(
                controller: new ScrollController(),
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: controller.content.thumbnail ?? "",
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) {
                        return Image.asset(
                          randomProfileImageAssetGenerator(),
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    Container(
                      width: double.infinity,
                      color: CustomColors.grayScale[100],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: COMMON_PADDING,
                          vertical: COMMON_VERTICAL_PADDING,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${controller.content.title}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    height: 1,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: COMMON_PADDING,
                          vertical: COMMON_VERTICAL_PADDING,
                        ),
                        child: Column(
                          children: [
                            // 프로필 섹션을 만든다.
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: COMMON_PADDING + 10,
                              ),
                              child: Row(
                                children: <Widget>[
                                  CachedNetworkImage(
                                    imageUrl: creator?.profileThumbnail ?? '',
                                    errorWidget: (context, url, error) =>
                                        CircleAvatar(
                                      radius: AVATOR_WIDTH,
                                      backgroundColor:
                                          CustomColors.grayScale[200],
                                      backgroundImage: Image.asset(
                                        randomProfileImageAssetGenerator(),
                                        fit: BoxFit.cover,
                                      ).image,
                                    ),
                                    imageBuilder: (context, imageProvider) =>
                                        CircleAvatar(
                                      radius: AVATOR_WIDTH,
                                      backgroundImage: imageProvider,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            creator?.realName ?? '',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(creator?.contact ?? '',
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey.shade600,
                                              ),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '컨텐츠 소개',
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      height: 1,
                                    ),
                              ),
                            ),
                            Text(
                              controller.content.description,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: CustomColors.grayScale[700]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ActionButton(
                      buttonText: '상담 신청하기',
                      onPressed: () async {
                        // TODO: 수정된 필드만 업데이트하기.
                        try {
                          await controller.makeReservation();
                          await rootController.fetchReservations();
                          rootController.tabIndex = 1;
                          showToast(
                            message: '상담 신청이 완료되었습니다.',
                          );
                          Get.back();
                        } catch (e) {
                          showToast(
                            message: '에러가 발생했습니다.',
                            messageType: MessageType.alert,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              onLoading: Center(child: LoadingIndicator()),
              onError: (msg) => Center(
                child: Text(msg ?? 'error'),
              ),
            ),
          ),
        );
      },
    );
  }
}
