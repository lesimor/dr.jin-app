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
import 'package:bookrabbit/src/utils/format.dart';

class SocialDayCard extends StatelessWidget {
  final ProductSummaryModel product;
  final bool preview;
  const SocialDayCard({super.key, required this.product, this.preview = false});

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(product.datetime);
    String dateTime =
        "${DateFormat('MM. dd').format(date)} (${getWeekday(date)})";

    return GestureDetector(
      onTap: () {
        if (preview) return;
        selectContentEvent(
          context,
          product,
        );
      },
      child: Container(
        width: 160,
        height: 232,
        child: Column(
          children: [
            Container(
              width: 160,
              height: 106,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    width: 160,
                    height: 106,
                    imageUrl: product.thumbnail,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            product.isAvailable
                                ? StatusTag(
                                    text: '모집중',
                                    borderColor: CustomColors.primaryGreen,
                                    backgroundColor: CustomColors.primaryGreen,
                                    fontColor: CustomColors.white,
                                  )
                                : StatusTag(
                                    text: '모집마감',
                                    backgroundColor:
                                        CustomColors.grayScale[300],
                                    fontColor: CustomColors.white,
                                    borderColor: CustomColors.grayScale[400],
                                  ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            StatusTag.participationTag(
                              context: context,
                              product: product,
                              fontColor: CustomColors.grayScale[700],
                              backgroundColor: CustomColors.grayScale[100],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide.none,
                  right: BorderSide(
                    color: CustomColors.grayScale[300]!,
                  ),
                  bottom: BorderSide(
                    color: CustomColors.grayScale[300]!,
                  ),
                  left: BorderSide(
                    color: CustomColors.grayScale[300]!,
                  ),
                ),
              ),
              padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
              ),
              width: 160,
              height: 126,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.button!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    product.address1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.overline,
                  ),
                  SizedBox(height: 2),
                  Text(
                    "${product.creator.nickname} | ${dateTime}",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.overline!.copyWith(
                          color: CustomColors.grayScale[700],
                        ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${formatPrice(product.price)}",
                        style: Theme.of(context).textTheme.button!.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
