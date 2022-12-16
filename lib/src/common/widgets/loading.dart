// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bookrabbit/src/themes/custom_colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/loading/loader-book.gif",
      color: CustomColors.primaryGreen,
      width: MediaQuery.of(context).size.width * 0.2,
    );
  }
}
