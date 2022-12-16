// Package imports:
import 'package:bookrabbit/src/common/data/provider.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:bookrabbit/src/features/authentication/controllers/auth_controller.dart';
import 'package:bookrabbit/src/features/products/models/participation.dart';
import 'package:bookrabbit/src/features/products/models/product.dart';
import 'package:bookrabbit/src/common/data/model/response.dart';
import 'package:bookrabbit/src/utils/dio_client.dart';

class ProductProvider extends ResourceProvider<ProductSummaryModel> {
  final elementFromJson;
  final elementToJson;
  ProductProvider({
    super.resourceName: "products",
  })  : elementFromJson = ((json) => ProductSummaryModel.fromJson(json)),
        elementToJson = ((elem) => elem.toJson());

  Future<CustomApiResponse<dynamic>> likeProduct(
    ProductDetailModel product,
  ) async {
    var authToken = await AuthController.getToken();
    var response = await DioClient().dio.patch(
          '/api/db/products/${product.id}/like/',
          options: Options(
            headers: {
              'Authorization': 'Token $authToken',
            },
          ),
        );
    return CustomApiResponse<dynamic>.fromJson(response.data, (json) {
      return json;
    });
  }

  Future<CustomApiResponse<dynamic>> unlikeProduct(
    ProductDetailModel product,
  ) async {
    var authToken = await AuthController.getToken();
    var response = await DioClient().dio.delete(
          '/api/db/products/${product.id}/like/',
          options: Options(
            headers: {
              'Authorization': 'Token $authToken',
            },
          ),
        );
    return CustomApiResponse<dynamic>.fromJson(response.data, (json) {
      return json;
    });
  }

  Future<ParticipationModel> participateFreeProduct(
    ProductDetailModel product,
  ) async {
    var authToken = await AuthController.getToken();
    var response = await DioClient().dio.post(
          '/api/db/products/${product.id}/participate/',
          options: Options(
            headers: {
              'Authorization': 'Token $authToken',
            },
          ),
        );
    return ParticipationModel.fromJson(response.data);
  }

  Future<CustomApiResponse> reportProduct(
    ProductDetailModel product,
    String content,
  ) async {
    var authToken = await AuthController.getToken();
    var response = await DioClient().dio.post(
          '/api/db/products/${product.id}/report/',
          data: {
            "content": content,
          },
          options: Options(
            headers: {
              'Authorization': 'Token $authToken',
            },
          ),
        );
    return CustomApiResponse.fromJson(response.data, (json) {
      return json;
    });
  }
}
