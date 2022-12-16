// Package imports:
import 'package:bookrabbit/src/common/data/provider.dart';
import 'package:bookrabbit/src/features/contents/models/club.dart';

// Project imports:

class ClubProvider extends ResourceProvider<ClubModel> {
  final elementFromJson;
  final elementToJson;
  ClubProvider({
    super.resourceName: "clubs",
  })  : elementFromJson = ((json) => ClubModel.fromJson(json)),
        elementToJson = ((elem) => elem.toJson());
}
