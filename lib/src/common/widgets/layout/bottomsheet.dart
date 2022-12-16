// Flutter imports:
import "package:flutter/material.dart";

// Project imports:
import 'package:bookrabbit/src/themes/custom_colors.dart';

Widget BottomSheetForButtonArea({
  required BuildContext context,
  required Widget widget,
  double? height,
}) {
  return Container(
    decoration: BoxDecoration(
      color: CustomColors.page,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      boxShadow: [
        BoxShadow(
          color: CustomColors.dim.withOpacity(0.1),
          blurRadius: 3,
          spreadRadius: 0,
          offset: Offset(0, -5),
        )
      ],
    ),
    child: Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: Container(
        height: height ?? 90,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 12,
        ),
        child: widget,
      ),
    ),
  );
}
