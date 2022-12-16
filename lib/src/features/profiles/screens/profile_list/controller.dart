// Flutter imports:
import 'package:bookrabbit/src/common/data/provider.dart';
import 'package:bookrabbit/src/features/authentication/models/user.dart';
import 'package:bookrabbit/src/features/profiles/data/product_provider.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/common/data/respository.dart';

class ProfileListController extends GetxController with StateMixin {
  ProfileListController();
  final resourceRepository = ResourceRepository();
  final productApi = ProductProvider();
  final ScrollController scrollController = ScrollController();

  ////////////////////////////////////////
  ResourceProviderV2<UserInModel, UserOutModel> get couselorProvider =>
      resourceRepository.counselorApi;

  // 상담사 리스트
  final _counselors = <UserOutModel>[].obs;
  get counselors => this._counselors;
  set counselors(value) => this._counselors.value = value;

  @override
  onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    change(null, status: RxStatus.loading());

    try {
      this.counselors = await this.couselorProvider.getList();
      change(null, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
