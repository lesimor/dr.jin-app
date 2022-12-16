// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bookrabbit/src/themes/custom_colors.dart';

class ListSubtitle extends StatelessWidget {
  final String subtitle;

  const ListSubtitle({
    Key? key,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 18, top: 4),
      child: Text(
        subtitle,
        style: Theme.of(context).textTheme.overline!.copyWith(
              color: CustomColors.grayScale[600],
            ),
      ),
    );
  }
}
