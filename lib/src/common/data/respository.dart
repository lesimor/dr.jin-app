// Project imports:
import 'package:bookrabbit/src/features/authentication/models/user.dart';
import 'package:bookrabbit/src/features/contents/models/club.dart';
import 'package:bookrabbit/src/features/matches/models/reservation.dart';
import 'package:bookrabbit/src/features/products/models/content.dart';
import 'package:bookrabbit/src/features/products/models/participation.dart';
import 'package:bookrabbit/src/features/products/models/product.dart';
import 'package:bookrabbit/src/features/products/models/resource.dart';
import 'package:bookrabbit/src/common/data/provider.dart';

class ResourceRepository {
  ResourceRepository();

  final resourceApi = ResourceProvider<ExternalResource>(
    resourceName: 'external_resources',
    elementFromJson: (json) => ExternalResource.fromJson(json),
    elementToJson: (elem) => elem.toJson(),
  );

  final clubApi = ResourceProvider<ClubModel>(
    resourceName: 'clubs',
    elementFromJson: (json) => ClubModel.fromJson(json),
    elementToJson: (elem) => elem.toJson(),
  );

  // final productApi = ResourceProvider<ProductSummaryModel>(
  //   resourceName: "products",
  //   elementFromJson: (json) => ProductSummaryModel.fromJson(json),
  //   elementToJson: (elem) => elem.toJson(),
  // );

  final counselorApi = ResourceProviderV2<UserInModel, UserOutModel>(
    resourceName: "users",
    elementFromJson: (json) => UserOutModel.fromJson(json),
    elementToJson: (elem) => elem.toJson(),
    headers: {"x-user-type": "counselor"},
  );

  final contentApi = ResourceProviderV2<ContentInModel, ContentOutModel>(
    resourceName: "contents",
    elementFromJson: (json) => ContentOutModel.fromJson(json),
    elementToJson: (elem) => elem.toJson(),
  );

  final reservationApi =
      ResourceProviderV2<ReservationInModel, ReservationOutModel>(
    resourceName: "reservations",
    elementFromJson: (json) => ReservationOutModel.fromJson(json),
    elementToJson: (elem) => elem.toJson(),
    headers: {"x-user-type": "customer"},
  );

  final productMutationApi = ResourceProvider<ProductDetailModel>(
    resourceName: "products",
    elementFromJson: (json) => ProductDetailModel.fromJson(json),
    elementToJson: (elem) => elem.toJsonForMutation(),
  );

  final participationApi = ResourceProvider<ParticipationModel>(
    resourceName: "participations",
    elementFromJson: (json) => ParticipationModel.fromJson(json),
    elementToJson: (elem) => elem.toJson(),
  );
}
