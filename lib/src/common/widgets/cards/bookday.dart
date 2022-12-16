// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:bookrabbit/src/common/widgets/tag.dart';
import 'package:bookrabbit/src/features/products/models/product.dart';
import 'package:bookrabbit/src/themes/custom_colors.dart';
import 'package:bookrabbit/src/utils/datetime.dart';
import 'package:bookrabbit/src/utils/events/content.dart';

class BookDayCard extends StatelessWidget {
  final ProductSummaryModel product;
  final bool preview;
  const BookDayCard({
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
          color: CustomColors.white,
          border: Border.all(
            color: CustomColors.grayScale[100]!,
          ),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: CustomColors.dim.withOpacity(0.05),
              blurRadius: 4,
              spreadRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: CachedNetworkImage(
                imageUrl: product.thumbnail,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(8),
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
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        StatusTag(
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/person.svg',
                                width: 7,
                                color: CustomColors.grayScale[800],
                              ),
                              SizedBox(width: 4),
                              Center(
                                child: Text(
                                  "${product.totalMemberIds.length}/${product.participantsNumber}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .overline!
                                      .copyWith(
                                        height: 1,
                                        color: CustomColors.grayScale[700],
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 5),
                        product.isAvailable
                            ? StatusTag(
                                text: '모집중',
                                borderColor: CustomColors.primaryGreen,
                                backgroundColor: CustomColors.primaryGreen,
                                fontColor: CustomColors.white,
                              )
                            : StatusTag(text: '모집마감'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
