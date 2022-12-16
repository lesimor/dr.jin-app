// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:bookrabbit/src/common/widgets/alert.dart';
import 'package:bookrabbit/src/common/widgets/layout/appbar.dart';
import 'package:bookrabbit/src/features/authentication/controllers/auth_controller.dart';
import 'package:bookrabbit/src/features/settings/screens/app_setting/controller.dart';
import 'package:bookrabbit/src/routing/routes.dart';
import 'package:bookrabbit/src/themes/app_theme.dart';
import 'package:bookrabbit/src/themes/custom_colors.dart';

class ListViewDividerWidget extends StatelessWidget {
  const ListViewDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.0,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: CustomColors.grayScale[100],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 14, color: CustomColors.grayScale[600]),
      ),
      visualDensity: VisualDensity(vertical: -4),
    );
  }
}

class SettingPage extends GetView<SettingController> {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<SettingController>(
      builder: (_) {
        return Scaffold(
          appBar: appBarBuilder(
            context: context,
            titleText: '설정',
            backgroundColor: CustomColors.grayScale[100]!,
          ),
          body: ListView(
            children: <Widget>[
              SectionTitle(title: '안내'),
              ListTile(
                title: Text('개인정보 처리방침', style: textTheme.bodyText2),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () async {
                  await launchUrl(
                    Uri.parse(
                      'https://sincere-frill-729.notion.site/8e5d37d6f9ac44f2be75950a0d6702f8',
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('이용약관', style: textTheme.bodyText2),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () async {
                  await launchUrl(
                    Uri.parse(
                      'https://sincere-frill-729.notion.site/82a2040896354b6b911f58fdc7572367',
                    ),
                  );
                },
              ),
              ListViewDividerWidget(),
              SectionTitle(title: '계정'),
              ListTile(
                title: Text('로그아웃', style: textTheme.bodyText2),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  showCustomAlert(
                    context: context,
                    title: '로그아웃하시겠어요?',
                    onConfirm: () async {
                      await AuthController.clear();
                      Get.toNamed(AppRoutes.LOGIN_WITH_EMAIL);
                    },
                  );
                },
              ),
              ListTile(
                title: Text('회원탈퇴', style: textTheme.bodyText2),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  showCustomAlert(
                    context: context,
                    title: '회원 탈퇴하시겠습니까?',
                    message: '모든 개인정보 및 활동내역이 모두 삭제되며 되돌릴 수 없습니다.',
                    onConfirm: () async {
                      await AuthController.to.deleteUser();
                      await AuthController.clear();
                      Get.toNamed(AppRoutes.LOGIN);
                    },
                  );
                },
              ),
              ListViewDividerWidget(),
              ListTile(
                title: Text('현재 버전', style: textTheme.bodyText2),
                trailing: Text("${_.version}(${_.buildNumber})"),
              ),
            ],
          ),
        );
      },
    );
  }
}
