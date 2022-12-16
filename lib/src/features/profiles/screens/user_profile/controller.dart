// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/common/widgets/toast.dart';
import 'package:bookrabbit/src/features/authentication/models/user.dart';
import 'package:bookrabbit/src/features/authentication/data/user_respository.dart';
import 'package:bookrabbit/src/themes/app_theme.dart';

class UserProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final UserRepository repository = UserRepository();

  // 프로필 사용자 아이디
  final _userId = 0.obs;
  set userId(value) => _userId.value = value;
  get userId => _userId.value;

  final _user = UserProfileModel().obs;
  get user => _user.value;
  set user(value) => _user.value = value;

  // 로딩 상태 관리
  final _isLoading = true.obs;
  get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  final _selectedTabIndex = Rx<int>(0);
  get selectedTabIndex => _selectedTabIndex.value;
  set selectedTabIndex(value) => _selectedTabIndex.value = value;

  late TabController tabController;

  final List<Tab> myTabs = <Tab>[
    Tab(
      child: Text(
        '참여',
        style: textTheme.bodyText2,
      ),
    ),
    Tab(
      child: Text(
        '찜',
        style: textTheme.bodyText2,
      ),
    ),
    Tab(
      child: Text(
        '책장',
        style: textTheme.bodyText2,
      ),
    ),
  ];

  @override
  void onInit() {
    ever(_userId, fetchUserProfile);
    tabController = TabController(length: myTabs.length, vsync: this);
    super.onInit();
  }

  void fetchUserProfile(userId) async {
    // 초기값에 대해서는 아무것도 수행하지 않음.
    if (userId == 0) return;

    // _userId를 이용해 사용자 정보를 가져온다.
    try {
      isLoading = true;
      _user.value = await UserRepository.getUserProfile(userId);
      isLoading = false;
    } catch (e) {
      showToast(
        message: '사용자 정보를 가져오는 중 에러가 발생했습니다.',
        messageType: MessageType.alert,
      );
    } finally {
      isLoading = false;
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
