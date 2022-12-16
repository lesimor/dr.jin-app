// Flutter imports:

import 'package:bookrabbit/src/features/authentication/models/user.dart';
import 'package:bookrabbit/src/utils/image.dart';
import 'package:flutter/material.dart';

// Package imports:

// Project imports:
import 'package:bookrabbit/src/themes/custom_colors.dart';

const BORDER_RADIUS = 8.0;

class CounselorCard extends StatelessWidget {
  final UserOutModel couselor;
  final Function(UserOutModel resource)? onTapCallback;
  const CounselorCard({
    super.key,
    required this.couselor,
    this.onTapCallback,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (onTapCallback != null) return onTapCallback!(couselor);
      },
      child: Column(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              decoration: BoxDecoration(
                color: CustomColors.grayScale[200],
                borderRadius: BorderRadius.circular(BORDER_RADIUS),
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.dim.withOpacity(0.05),
                    blurRadius: 4,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(BORDER_RADIUS),
                child: Image.asset(
                  randomProfileImageAssetGenerator(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      couselor.username,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.button!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Text(
                      "${couselor.introduction}",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.overline!.copyWith(
                            color: CustomColors.grayScale[900],
                            height: 1.2,
                          ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
