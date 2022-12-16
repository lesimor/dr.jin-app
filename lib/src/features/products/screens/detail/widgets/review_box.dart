// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:bookrabbit/src/common/data/model/review.dart';
import 'package:bookrabbit/src/themes/custom_colors.dart';

class ReviewBox extends StatelessWidget {
  final ReviewModel review;

  const ReviewBox({
    Key? key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    final hasProfileThumbnail = review.writer.profileThumbnail.isNotEmpty;
    final createdAt = DateFormat('yy.MM.dd').format(review.createdAt);
    final imageLength = review.images.length;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 22,
              right: 12,
              left: 22,
            ),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: hasProfileThumbnail
                  ? CachedNetworkImage(
                      width: 36,
                      height: 36,
                      imageUrl: review.writer.profileThumbnail,
                    )
                  : Image.asset(
                      width: 36,
                      height: 36,
                      "assets/images/default_profile.png",
                    ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 16),
              child: Column(
                children: [
                  SizedBox(height: 22),
                  Row(
                    children: [
                      Text(
                        "${review.writer.nickname} | ${createdAt}",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ],
                  ),
                  Container(
                    // height: 72,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(),
                    child: Text(
                      review.productReview,
                      // maxLines: 3,
                      // overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: CustomColors.grayScale[700],
                          ),
                    ),
                  ),
                  SizedBox(height: 18),
                  Row(
                    children: [
                      for (int i = 0; i < imageLength; i++)
                        Container(
                          width: 132,
                          height: 132,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: review.images[i],
                            width: 132,
                            height: 132,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
