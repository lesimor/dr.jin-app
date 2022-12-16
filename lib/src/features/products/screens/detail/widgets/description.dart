// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bookrabbit/src/themes/custom_colors.dart';

class ProductDescription extends StatelessWidget {
  final String? title;
  final String? description;
  const ProductDescription({
    super.key,
    @required this.title,
    @required this.description,
  }) : assert(title != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title as String,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            description as String,
            // overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.button!.copyWith(
                  color: CustomColors.grayScale[600],
                ),
          ),
        ],
      ),
    );
  }
}
