// Flutter imports:
import 'package:bookrabbit/src/common/data/respository.dart';
import 'package:bookrabbit/src/features/matches/models/reservation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/products/models/product.dart';

class RootController extends GetxController with StateMixin {
  final ResourceRepository repository = ResourceRepository();
  RootController();

  RxInt _tabIndex = 0.obs;
  get tabIndex => _tabIndex.value;
  set tabIndex(value) {
    _tabIndex.value = value;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    await fetchReservations();
  }

  void changeTabIndex(int index, BuildContext context) {
    _tabIndex.value = index;
    update();
  }

  final _user = Rxn<ProductSummaryModel>(null).obs;
  get user => this._user.value;
  set user(value) => this._user.value = value;

  // 우선 Reservations를 이관한다.
  final _reservations = <ReservationOutModel>[].obs;
  get reservations => this._reservations;
  set reservations(value) => this._reservations.value = value;

  Future<List<ReservationOutModel>?> fetchReservations() async {
    change(null, status: RxStatus.error());
    this.reservations = await repository.reservationApi.getList();
    change(null, status: RxStatus.success());
    return null;
  }
}
