// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:bookrabbit/src/common/widgets/tag.dart';
import 'package:bookrabbit/src/features/products/models/product.dart';
import 'package:bookrabbit/src/themes/custom_colors.dart';
import 'package:bookrabbit/src/utils/datetime.dart';
import 'package:bookrabbit/src/utils/events/content.dart';

class CommonProductCard extends StatelessWidget {
  final ProductSummaryModel product;
  final bool preview;
  const CommonProductCard({
    super.key,
    required this.product,
    this.preview = false,
  });

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(product.datetime);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (preview) return;
        selectContentEvent(
          context,
          product,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: CustomColors.grayScale[200]!,
          ),
        ),
        height: 104,
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    clipBehavior: Clip.hardEdge,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: CachedNetworkImageProvider(
                          product.thumbnail,
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
                  isBookdayProduct(product)
                      ? Container(
                          height: double.infinity,
                          child: Center(
                            child: CachedNetworkImage(
                              imageUrl: product.thumbnail,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl: product.thumbnail,
                            fit: BoxFit.cover,
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StatusTag.participationTag(
                      context: context,
                      product: product,
                      backgroundColor: CustomColors.black.withOpacity(0.44),
                      fontColor: CustomColors.white,
                      borderColor: CustomColors.grayScale[600]!,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${product.title}${!product.allowed! ? ' (승인대기중)' : ''}",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.button!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Text(
                      "${product.address1}",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.overline!.copyWith(
                            color: CustomColors.grayScale[700],
                          ),
                    ),
                    Text(
                      "${DateFormat('MM. dd').format(date)} (${getWeekday(date)})",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.overline!.copyWith(
                            color: CustomColors.grayScale[700],
                          ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isBookdayProduct(ProductSummaryModel product) {
    return product.category?.code == 'BD';
  }
}
