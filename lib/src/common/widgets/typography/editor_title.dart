import 'package:flutter/material.dart';

import 'package:bookrabbit/src/themes/custom_colors.dart';

class EditorTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  const EditorTitle({
    super.key,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle != null
            ? Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.overline!.copyWith(
                          color: CustomColors.grayScale[600],
                        ),
                  ),
                ],
              )
            : Container()
      ],
    );
  }
}
