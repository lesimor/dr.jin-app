// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/products/models/product.dart';
import 'package:bookrabbit/src/routing/routes.dart';

void selectContentEvent(BuildContext context, ProductSummaryModel product) {
  FirebaseAnalytics.instance.logEvent(
    name: "select_content",
    parameters: {
      "content_type": "${product.category?.code ?? 'unknown'}",
      "item_id": "${product.id}",
      "event_origin_page": "${ModalRoute.of(context)?.settings.name}",
      "is_able_to_join": "${product.isAvailable}"
    },
  );

  Get.toNamed(
    AppRoutes.PRODUCT_VIEWER,
    arguments: {
      'productId': product.id,
    },
  );
}
