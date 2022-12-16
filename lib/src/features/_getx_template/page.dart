// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/_getx_template/controller.dart';

class ModuleTemplatePage extends GetView<TemplatePageController> {
  const ModuleTemplatePage({super.key});

  @override
  Widget build(BuildContext context) {
    // User의 목록을 가져온다.
    return Scaffold(
      body: SafeArea(
        child: controller.obx(
          (_) => Center(child: Text('hello')),
          onLoading: Center(child: Text('loading')),
          onError: (msg) => Center(
            child: Text(msg ?? 'error'),
          ),
        ),
      ),
    );
  }
}
