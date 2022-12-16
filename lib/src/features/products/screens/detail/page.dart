// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:bookrabbit/src/common/widgets/layout/appbar.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

// Project imports:
import 'package:bookrabbit/src/common/widgets/alert.dart';
import 'package:bookrabbit/src/common/widgets/loading.dart';
import 'package:bookrabbit/src/common/widgets/toast.dart';
import 'package:bookrabbit/src/common/widgets/user_image.dart';
import 'package:bookrabbit/src/features/authentication/controllers/auth_controller.dart';
import 'package:bookrabbit/src/features/products/models/product.dart';
import 'package:bookrabbit/src/common/data/model/response.dart';
import 'package:bookrabbit/src/features/products/screens/editor/controller.dart';
import 'package:bookrabbit/src/features/products/screens/detail/controller.dart';
import 'package:bookrabbit/src/features/products/screens/detail/report/controller.dart';
import 'package:bookrabbit/src/features/products/screens/detail/widgets/description.dart';
import 'package:bookrabbit/src/routing/routes.dart';
import 'package:bookrabbit/src/themes/custom_colors.dart';
import 'package:bookrabbit/src/utils/datetime.dart';
import 'package:bookrabbit/src/utils/dynamic_link.dart';
import 'package:bookrabbit/src/utils/format.dart';
import 'package:bookrabbit/src/utils/logger.dart';
import 'package:bookrabbit/src/utils/share.dart';
import 'package:bookrabbit/src/utils/webview.dart';

const defaultTitleTextSize = 13.0;

Color defaultHorizontalLineColor = Colors.grey.shade200;
Color defaultKeyTextColor = Colors.grey.shade600;

class ProductViewerPage extends GetView<ProductViewerController> {
  const ProductViewerPage({super.key});

  Container sectionBorder() {
    return Container(
      height: 10,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            // POINT
            color: Colors.grey.shade300,
            width: 1.0,
          ),
          top: BorderSide(
            // POINT
            color: Colors.grey.shade300,
            width: 1.0,
          ),
        ),
        color: defaultHorizontalLineColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    logger.d(
      'ProductViewerPage build with product id ${Get.arguments['productId']}',
    );

    return GetX<ProductViewerController>(
      init: ProductViewerController(),
      initState: (_) async {
        await Get.find<ProductViewerController>()
            .fetchProduct(id: Get.arguments['productId']);
        final authController = Get.find<AuthController>();
        ;
        Get.find<ProductViewerController>()
            .initUserStatus(authController.currentUser!);
      },
      builder: (_) {
        final List<Tab> detailTabs = <Tab>[
          Tab(text: "상세정보"),
          // Tab(
          //   child: Container(
          //     child: Row(
          //       children: [
          //         Text("참여 후기"),
          //         SizedBox(width: 4),
          //         TabBadge(count: reiviewCount),
          //       ],
          //     ),
          //   ),
          // ),
        ];

        final tabController = TabController(
          length: detailTabs.length,
          vsync: _,
        );

        final productInfoTextTheme =
            Theme.of(context).textTheme.button!.copyWith(
                  letterSpacing: 0.3,
                  height: 1.4,
                  color: CustomColors.grayScale[700],
                  fontWeight: FontWeight.bold,
                );

        return Scaffold(
          appBar: appBarBuilder(
            context: context,
            actions: _buildActionButtons(
              context,
              _,
            ),
          ),
          body: _.isLoading
              ? Center(child: LoadingIndicator())
              : Container(
                  color: CustomColors.page,
                  child: NestedScrollView(
                    controller: new ScrollController(),
                    headerSliverBuilder: (context, value) {
                      return [
                        SliverToBoxAdapter(
                          child: Stack(
                            children: [
                              Container(
                                height: 429,
                                clipBehavior: Clip.hardEdge,
                                decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      _.product.thumbnail ?? "",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: new BackdropFilter(
                                  filter: new ImageFilter.blur(
                                    sigmaX: 15.0,
                                    sigmaY: 15.0,
                                  ),
                                  child: new Container(
                                    decoration: new BoxDecoration(
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: CachedNetworkImage(
                                  imageUrl: _.product.thumbnail ?? "",
                                ),
                                top: 32,
                                left: 0,
                                right: 0,
                                bottom: 32,
                              ),
                            ],
                          ),
                        ),
                        // Header
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 22,
                              left: 28,
                              right: 28,
                              bottom: 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${_.product.productType == ProductType.bookday ? '북데이' : '소셜데이'} | ${_.product.creator?.nickname}',
                                  style: Theme.of(context).textTheme.button,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _.product.title ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                        maxLines: 2,
                                      ),
                                    ),
                                    LikeButton(
                                      isLiked: _.isLiked,
                                      likeBuilder: (bool isLiked) {
                                        return Icon(
                                          Icons.favorite,
                                          color: isLiked
                                              ? CustomColors.primaryGreen
                                              : CustomColors.grayScale[400],
                                          size: 24,
                                        );
                                      },
                                      bubblesColor: BubblesColor(
                                        dotPrimaryColor:
                                            CustomColors.primaryGreen,
                                        dotSecondaryColor:
                                            CustomColors.grayScale[400]!,
                                      ),
                                      onTap: (bool isLiked) async {
                                        CustomApiResponse res;
                                        if (isLiked) {
                                          res = await _.repository
                                              .unlikeProduct(_.product);
                                        } else {
                                          res = await _.repository
                                              .likeProduct(_.product);
                                        }
                                        _.isLiked =
                                            res.isError ? isLiked : !isLiked;

                                        // 사용자 정보 동기화 (비동기)
                                        Get.find<AuthController>()
                                            .initCurrentUser();
                                        return _.isLiked;
                                      },
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    formatPrice(_.product.price!),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            child: TabBar(
                              controller: tabController,
                              tabs: detailTabs,
                              isScrollable: true,
                              padding: const EdgeInsets.only(
                                left: 28,
                              ),
                              indicatorColor: CustomColors.primaryGreen,
                              labelColor: CustomColors.primaryGreen,
                              unselectedLabelColor: CustomColors.grayScale[400],
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: CustomColors.grayScale[300]!,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ];
                    },
                    body: Container(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          // 상세 정보
                          Container(
                            padding: const EdgeInsets.only(
                              left: 24,
                              right: 24,
                              top: 22,
                            ),
                            child: ListView(
                              children: [
                                Wrap(
                                  spacing: 6,
                                  direction: Axis.vertical,
                                  children: [
                                    Wrap(
                                      spacing: 10,
                                      children: [
                                        Icon(Icons.schedule),
                                        Text(
                                          '${getSimpleDayFormat(_.product.datetime)}',
                                          style: productInfoTextTheme,
                                        ),
                                      ],
                                    ),
                                    Wrap(
                                      spacing: 10,
                                      children: [
                                        Icon(Icons.place),
                                        Text(
                                          _.product.address1!,
                                          style: productInfoTextTheme,
                                        ),
                                      ],
                                    ),
                                    Wrap(
                                      spacing: 10,
                                      children: [
                                        Icon(Icons.people),
                                        Text(
                                          '${_.product.totalMemberIds?.length} / ${_.product.participantsNumber}명',
                                          style: productInfoTextTheme,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 80,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      SimpleAvatarWidget(
                                        user: _.product.creator,
                                        padding: EdgeInsets.only(right: 8.0),
                                        badge: FaIcon(
                                          FontAwesomeIcons.crown,
                                          size: 13.0,
                                          color: CustomColors.primaryGreen,
                                        ),
                                      ),
                                      ..._.product.participations!
                                          .map(
                                            (participation) =>
                                                SimpleAvatarWidget(
                                              user: participation.user,
                                              padding:
                                                  EdgeInsets.only(right: 8.0),
                                            ),
                                          )
                                          .toList()
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children:
                                        _buildDescriptionContents(_.product),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // 참여 후기
                          // Container(
                          //   child: ListView(
                          //     children: [
                          //       ...product.reviews!.map((review) {
                          //         return ReviewBox(review: review);
                          //       }).toList(),
                          //       SizedBox(height: 50),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: CustomColors.page,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: CustomColors.dim,
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: Offset(0, -2),
                )
              ],
            ),
            child: SafeArea(
              child: Container(
                height: 90,
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 12,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: CustomColors.grayScale[200],
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: OutlinedButton(
                        onPressed: () => {
                          getShortLink(
                            DynamicLink.REDIRECT,
                            AppRoutes.PRODUCT_VIEWER,
                            _.product.id.toString(),
                          ).then(
                            (link) => {
                              ShareManager().shareProductViaKakaoTalk(
                                link: link,
                                title: _.product.title!,
                                imageUrl: _.product.thumbnail!,
                                description: _.product.description,
                              ),
                            },
                          )
                        },
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/icon/sns/icon_share.svg",
                            width: 24,
                            height: 24,
                            color: CustomColors.grayScale[800],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 54,
                        decoration: BoxDecoration(
                          color: CustomColors.primaryGreen,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: _.isParticipated
                            ? OutlinedButton(
                                onPressed: () {
                                  routeKakaoWebview(_.product.chatUrl!);
                                },
                                child: Center(
                                  child: Text(
                                    '채팅방으로 이동하기',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          color: CustomColors.white,
                                          fontWeight: FontWeight.bold,
                                          height: 1,
                                        ),
                                  ),
                                ),
                              )
                            : _.applyNotAllowed
                                ? OutlinedButton(
                                    onPressed: null,
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.grey,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '모집 마감',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              color: CustomColors.white,
                                              fontWeight: FontWeight.bold,
                                              height: 1,
                                            ),
                                      ),
                                    ),
                                  )
                                : OutlinedButton(
                                    onPressed: () async {
                                      showCustomAlert(
                                        context: context,
                                        title:
                                            '[${_.product.title}]\n신청하시겠습니까?',
                                        onConfirm: () async {
                                          Navigator.pop(context);
                                          // 모임참여 API 호출
                                          try {
                                            var res = await _.repository
                                                .participateFreeProduct(
                                              _.product,
                                            );
                                            _.isParticipated = true;
                                            showParticipationSuccessDialog(
                                              context,
                                              _.product,
                                            );
                                          } on Exception {
                                            showCustomAlert(
                                              context: context,
                                              title: '에러 발생',
                                              onConfirm: () {},
                                            );
                                          }
                                        },
                                      );
                                    },
                                    child: Center(
                                      child: Text(
                                        '신청하기',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              color: CustomColors.white,
                                              fontWeight: FontWeight.bold,
                                              height: 1,
                                            ),
                                      ),
                                    ),
                                  ),
                      ),
                    )
                    // Expanded(
                    //   flex: 1,
                    //   child: Container(
                    //     margin: const EdgeInsets.all(5),
                    //     child: OutlinedButton(
                    //       onPressed: () {
                    //         Get.toNamed(
                    //           AppRoutes.PRODUCT_REVIEW,
                    //           arguments: {'product': product},
                    //         );
                    //       },
                    //       child: const Text('후기 작성'),
                    //     ),
                    //   ),
                    // ),
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
    ProductViewerController controller,
  ) {
    if (controller.isCreator) {
      // 해당 모임을 만든 사람의 경우
      return <Widget>[
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            if (controller.isOutDated) {
              showToast(message: '지난 모임은 수정할 수 없습니다.');
            } else {
              Get.toNamed(
                AppRoutes.PRODUCT_SETTINGS,
                arguments: {
                  'product': controller.product,
                },
              );
            }
          },
        )
      ];
    } else
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
                      'userName': controller.product.creator.nickname,
                      'userId': controller.product.creator.id,
                      'reportType': ReportType.product,
                      'product': controller.product
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ];
  }

  List<Widget> _buildDescriptionContents(ProductDetailModel product) {
    return [
      ...[
        new Map()
          ..['title'] = "🥳 모임 소개"
          ..['content'] = product.description,
        new Map()
          ..['title'] = "👍 이런 분께 추천!"
          ..['content'] = product.dRecommendation,
        new Map()
          ..['title'] = "🕑 모임 시간"
          ..['content'] = product.dPlan,
        new Map()
          ..['title'] = "📍 모임 장소"
          ..['content'] = product.dLocation,
        new Map()
          ..['title'] = "🏃🏻‍♀️ 참여 방법"
          ..['content'] = product.dParticipation,
      ]
          .where(
            (e) => e['content'] != null && (e['content'] as String).isNotEmpty,
          )
          .map(
            (e) => ProductDescription(
              title: e['title'],
              description: e['content'],
            ),
          )
          .toList(),
      SizedBox(
        height: 28,
      ),
    ];
  }

  showParticipationSuccessDialog(
    BuildContext context,
    ProductDetailModel product,
  ) {
    showCustomAlert(
      context: context,
      title: '신청 완료',
      messageWidget: Container(
        child: Column(
          children: [
            SizedBox(height: 8),
            Row(
              children: [
                Text("·\n"),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    "오픈카톡방에서 모임 리더가 모임에 대한 상세한 일정과 장소등을 안내해드려요.",
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text("·\n"),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '하단의 "채팅방으로 이동하기" 버튼으로 언제든 오픈카톡방에 들어갈 수 있어요.',
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      cancelText: "닫기",
      confirmText: "채팅방으로 이동",
      onConfirm: () async {
        routeKakaoWebview(product.chatUrl);
        Navigator.pop(context);
      },
    );
  }
}
