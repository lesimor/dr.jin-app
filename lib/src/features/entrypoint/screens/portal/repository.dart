// Project imports:
import 'package:bookrabbit/src/features/contents/models/club.dart';
import 'package:bookrabbit/src/features/products/data/product_provider.dart';
import 'package:bookrabbit/src/features/products/models/resource.dart';
import 'package:bookrabbit/src/common/data/provider.dart';

class HomeRepository {
  HomeRepository();

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
  final productApi = ProductProvider();
}
