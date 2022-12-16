// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/common/widgets/cards/common.dart';
import 'package:bookrabbit/src/common/widgets/layout/appbar.dart';
import 'package:bookrabbit/src/common/widgets/loading.dart';
import 'package:bookrabbit/src/features/products/models/product.dart';
import 'package:bookrabbit/src/features/authentication/models/user.dart';
import 'package:bookrabbit/src/features/products/screens/detail/report/controller.dart';
import 'package:bookrabbit/src/features/profiles/screens/user_profile/controller.dart';
import 'package:bookrabbit/src/common/widgets/tabbar.dart';
import 'package:bookrabbit/src/routing/routes.dart';
import 'package:bookrabbit/src/themes/custom_colors.dart';

class UserProfilePage extends GetView<UserProfileController> {
  @override
  Widget build(BuildContext context) {
    return GetX<UserProfileController>(
      init: UserProfileController(),
      builder: (_) {
        _.userId = int.parse(Get.parameters['userId']!);
        UserProfileModel user = _.user;
        List<ProductSummaryModel> participatedProducts =
            (user.participations ?? [])
                .map((participation) => participation.product)
                .toList();
        List<ProductSummaryModel> createdProducts =
            (user.createdProducts ?? []).toList();

        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: appBarBuilder(
              context: context,
              actions: _buildActionButtons(context, controller),
            ),
            body: Obx(
              () => _.isLoading
                  ? Center(child: LoadingIndicator())
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 30.0,
                                  backgroundColor: CustomColors.grayScale[200],
                                  child: user.profileThumbnail != null
                                      ? ClipOval(
                                          child: CachedNetworkImage(
                                            imageUrl: user.profileThumbnail!,
                                          ),
                                        )
                                      : SvgPicture.asset(
                                          'assets/icon/common/rabbit.svg',
                                          width: 30,
                                          color: CustomColors.white,
                                        ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${user.nickname ?? ''}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .button!
                                          .copyWith(
                                            height: 0,
                                            color: CustomColors.black,
                                          ),
                                    ),
                                  ],
                                ),
                                Text(
                                  user.introduction != ""
                                      ? user.introduction!
                                      : "자기소개가 없습니다.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .button!
                                      .copyWith(
                                        color: CustomColors.grayScale[700],
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 60,
                            child: AppBar(
                              bottom: TabBar(
                                onTap: (index) {
                                  controller.selectedTabIndex = index;
                                  //your currently selected index
                                },
                                tabs: <Widget>[
                                  MyPageTab(
                                    svgPath:
                                        'assets/icon/my_page/participation.svg',
                                    text: '참여',
                                    count: participatedProducts.length,
                                    selected: controller.selectedTabIndex == 0,
                                  ),
                                  MyPageTab(
                                    svgPath: 'assets/icon/my_page/leader.svg',
                                    text: '진행',
                                    count: createdProducts.length,
                                    selected: controller.selectedTabIndex == 1,
                                  ),
                                ],
                                labelColor: CustomColors.grayScale[800],
                                unselectedLabelColor:
                                    CustomColors.grayScale[400],
                                indicatorColor: CustomColors.grayScale[800],
                              ),
                              backgroundColor: CustomColors.white,
                              elevation: 0,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: TabBarView(
                              children: [
                                CommonProductListView(
                                  products: participatedProducts,
                                  placeHolder: '참여한 모임이 없습니다.',
                                ),
                                CommonProductListView(
                                  products: createdProducts,
                                  placeHolder: '진행한 모임이 없습니다.',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildActionButtons(
    BuildContext context,
    UserProfileController controller,
  ) {
    return <Widget>[
      PopupMenuButton(
        elevation: 0,
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'actionItems',
            child: ListTile(
              leading: Icon(Icons.warning),
              title: Text(
                "신고하기",
                style: Theme.of(context).textTheme.button,
              ),
              onTap: () {
                Navigator.pop(context, "actionItems");
                Get.toNamed(
                  AppRoutes.PRODUCT_REPORT,
                  arguments: {
                    'userName': controller.user.nickname,
                    'userId': controller.user.id,
                    'reportType': ReportType.user,
                  },
                );
              },
            ),
          ),
        ],
      ),
    ];
  }
}

class CommonProductListView extends StatelessWidget {
  final List<ProductSummaryModel> products;
  final String? placeHolder;
  const CommonProductListView({
    super.key,
    required this.products,
    this.placeHolder,
  });

  @override
  Widget build(BuildContext context) {
    return products.isEmpty
        ? Center(
            child: Text(
              placeHolder ?? '컨텐츠가 없습니다.',
              style: TextStyle(
                color: CustomColors.grayScale[600],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: ListView(
              children: products.map<Widget>((product) {
                return Container(
                  height: 104 + 12,
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                  ),
                  child: CommonProductCard(product: product),
                );
              }).toList(),
            ),
          );
  }
}
