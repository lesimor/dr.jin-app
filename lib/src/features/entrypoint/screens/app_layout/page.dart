// Flutter imports:
import 'package:bookrabbit/src/features/matches/screens/chat_list/page.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/entrypoint/screens/app_layout/controller.dart';
import 'package:bookrabbit/src/features/entrypoint/screens/portal/page.dart';
import 'package:bookrabbit/src/features/profiles/screens/my_profile/page.dart';
import 'package:bookrabbit/src/themes/custom_colors.dart';

class LandingPage extends GetView<RootController> {
  final UNSELECTED_BOTTOM_TAB_COLOR = CustomColors.grayScale[600];

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (_) => Scaffold(
        body: IndexedStack(
          index: controller.tabIndex,
          children: [
            HomePage(),
            ChatListPage(),
            MyProfilePage(
              editable: true,
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: CustomColors.grayScale[100],
            border: Border(
              top: BorderSide(
                color: CustomColors.grayScale[200]!,
                width: 1,
              ),
            ),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12.0,
            selectedItemColor: CustomColors.primaryGreen,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedFontSize: 12.0,
            unselectedItemColor: UNSELECTED_BOTTOM_TAB_COLOR,
            onTap: (index) => controller.tabIndex = index,
            currentIndex: controller.tabIndex,
            backgroundColor: CustomColors.grayScale[100],
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icon/bottom_navbar/ic-discussion.svg',
                  height: 20,
                  color: UNSELECTED_BOTTOM_TAB_COLOR,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icon/bottom_navbar/ic-discussion.svg',
                  height: 20,
                ),
                label: '상담찾기',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icon/bottom_navbar/ic-chat.svg',
                  height: 20,
                  color: UNSELECTED_BOTTOM_TAB_COLOR,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icon/bottom_navbar/ic-chat.svg',
                  height: 20,
                ),
                label: '대화',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icon/bottom_navbar/ic-settings.svg',
                  height: 20,
                  color: UNSELECTED_BOTTOM_TAB_COLOR,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icon/bottom_navbar/ic-settings.svg',
                  height: 20,
                ),
                label: '설정',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
