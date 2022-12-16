// Flutter imports:

import 'package:bookrabbit/src/features/products/models/content.dart';
import 'package:bookrabbit/src/routing/routes.dart';
import 'package:bookrabbit/src/utils/image.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';

// Project imports:
import 'package:bookrabbit/src/themes/custom_colors.dart';
import 'package:get/get.dart';



class ContentCard extends StatelessWidget {
  final ContentOutModel content;
  final bool preview;
  const ContentCard({
    super.key,
    required this.content,
    this.preview = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Get.toNamed(
          AppRoutes.CONTENT_DETAIL,
          arguments: {
            'contentId': content.id,
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: CustomColors.dim.withOpacity(0.05),
              blurRadius: 3,
              spreadRadius: 4,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: CustomColors.grayScale[100],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl: content.thumbnail ?? '',
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Image.asset(
                        randomGroupImageAssetGenerator(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 14),
                  color: CustomColors.white,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                content.title!,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "${content.description}",
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.overline!.copyWith(
                                color: CustomColors.grayScale[700],
                              ),
                        ),
                      ),
                    ],
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
