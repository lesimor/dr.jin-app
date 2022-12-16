// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';

// Project imports:
import 'package:bookrabbit/src/features/products/models/resource.dart';
import 'package:bookrabbit/src/themes/custom_colors.dart';

class PreviewCard extends StatelessWidget {
  final ExternalResource resource;
  final Function(ExternalResource resource)? onTapCallback;
  const PreviewCard({
    super.key,
    required this.resource,
    this.onTapCallback,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (onTapCallback != null) return onTapCallback!(resource);
      },
      child: Container(
        height: 104,
        child: Row(
          children: [
            Container(
              width: 71,
              height: 104,
              child: CachedNetworkImage(
                imageUrl: resource.thumbnail,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resource.title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.button!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Text(
                      "${resource.creators.length > 0 ? resource.creators[0] : ''}",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.overline!.copyWith(
                            color: CustomColors.grayScale[900],
                          ),
                    ),
                    Flexible(
                      child: Text(
                        "${resource.content}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
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
    );
  }
}
