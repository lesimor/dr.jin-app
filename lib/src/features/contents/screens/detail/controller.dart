// Package imports:
import 'package:bookrabbit/src/common/data/provider.dart';
import 'package:bookrabbit/src/common/data/respository.dart';
import 'package:bookrabbit/src/features/matches/models/reservation.dart';
import 'package:bookrabbit/src/features/products/models/content.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/contents/screens/detail/repository.dart';

class ContentDetailPageController extends GetxController with StateMixin {
  final resourceRepository = ResourceRepository();
  ResourceProviderV2<ContentInModel, ContentOutModel> get contentApi =>
      resourceRepository.contentApi;

  ResourceProviderV2<ReservationInModel, ReservationOutModel>
      get reservationApi => resourceRepository.reservationApi;

  final ClubDetailRepository repository = ClubDetailRepository();
  ContentDetailPageController();

  final _content = Rx<ContentOutModel?>(null);
  set content(value) => this._content.value = value;
  get content => this._content.value;

  final _contentId = Rx<String?>(null);
  set contentId(value) => this._contentId.value = value;
  get contentId => this._contentId.value;

  @override
  onInit() {
    ever(_contentId, (_) => fetchContent(_ as String?));
    super.onInit();
  }

  fetchContent(String? value) async {
    if (value == null) {
      // value가 null인 경우 에러 상태로 변경.
      change(null, status: RxStatus.error());
      return;
    }
    change(null, status: RxStatus.loading());
    try {
      this.content = await contentApi.getById(value);
      this.contentId = value;
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }

    change(null, status: RxStatus.success());
  }

  Future<ReservationOutModel?> makeReservation() async {
    ReservationInModel reservation = ReservationInModel(
      contentId: contentId,
      startAt: DateTime.now(),
      endAt: DateTime.now().add(Duration(hours: 1)),
    );

    var result = await reservationApi.create(reservation);

    return result;
  }

  Future<List<ReservationOutModel?>> getReservations() async {
    List<ReservationOutModel?> reservations = await reservationApi.getList();
    return reservations;
  }
}
