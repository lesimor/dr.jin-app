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
import 'package:bookrabbit/src/features/authentication/controllers/auth_controller.dart';
import 'package:bookrabbit/src/features/products/models/product.dart';
import 'package:bookrabbit/src/features/profiles/screens/my_profile/controller.dart';
import 'package:bookrabbit/src/routing/routes.dart';
import 'package:bookrabbit/src/themes/custom_colors.dart';

class MyProfilePage extends GetView<MyProfileController> {
  bool editable;
  MyProfilePage({
    super.key,
    this.editable = false,
  });

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: appBarBuilder(
        context: context,
        titleText: '마이페이지',
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.settings),
            onPressed: () => {
              Get.toNamed(AppRoutes.SETTINGS),
            },
          )
        ],
      ),
      body: Obx(
        () => authController.isLoading!
            ? Center(child: LoadingIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.PROFILE_EDITOR);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 30.0,
                                    backgroundColor:
                                        CustomColors.grayScale[200],
                                    child: authController.currentUser!
                                                .profileThumbnail !=
                                            null
                                        ? ClipOval(
                                            child: CachedNetworkImage(
                                              imageUrl: authController
                                                  .currentUser!
                                                  .profileThumbnail,
                                            ),
                                            
                                          )
                                        : SvgPicture.asset(
                                            'assets/icon/common/rabbit.svg',
                                            width: 30,
                                            color: CustomColors.white,
                                          ),
                                  ),
                                  Positioned(
                                    right: 0.0,
                                    bottom: 0.0,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Icon(
                                          Icons.edit,
                                          size: 10,
                                          color: CustomColors.primaryGreen,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: CustomColors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: CustomColors.grayScale[300]!,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${authController.currentUser!.username}',
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
                                authController.currentUser!.introduction,
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
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
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
