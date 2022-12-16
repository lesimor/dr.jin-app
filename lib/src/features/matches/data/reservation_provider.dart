// Package imports:
import 'package:bookrabbit/src/common/data/provider.dart';
import 'package:bookrabbit/src/features/matches/models/reservation.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:bookrabbit/src/features/authentication/controllers/auth_controller.dart';
import 'package:bookrabbit/src/utils/dio_client.dart';

class ReservationProvider
    extends ResourceProviderV2<ReservationInModel, ReservationOutModel> {
  final elementFromJson;
  final elementToJson;
  ReservationProvider({
    super.resourceName: "reservations",
  })  : elementFromJson = ((json) => ReservationOutModel.fromJson(json)),
        elementToJson = ((elem) => elem.toJson());

  // 특정 컨텐츠의 예약을 생성한다.
  Future<ReservationOutModel?> create(
    ReservationInModel reservation,
  ) async {
    var authToken = await AuthController.getToken();
    var response = await DioClient().dio.post(
          '/reservations/',
          options: Options(
            headers: {
              'Authorization': 'Token $authToken',
            },
          ),
        );
    return ReservationInModel.fromJson(response.data)
        as Future<ReservationOutModel?>;
  }
}
