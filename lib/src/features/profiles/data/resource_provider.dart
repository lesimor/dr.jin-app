// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:bookrabbit/environment.dart';
import 'package:bookrabbit/src/features/authentication/controllers/auth_controller.dart';
import 'package:bookrabbit/src/features/products/models/resource.dart';
import 'package:bookrabbit/src/common/data/model/response.dart';
import 'package:bookrabbit/src/utils/dio_client.dart';
import 'package:bookrabbit/src/utils/logger.dart';

class ExternalResourceProvider {
  ExternalResourceProvider();

  Future<ExternalResource?> getOrCreateExternalResources(
    ExternalResource r,
  ) async {
    var authToken = await AuthController.getToken();
    var payload = r.toJson();
    // find_or_create 플래그 유통
    payload['find_or_create'] = true;
    var response = await DioClient().dio.post(
          '/api/db/external_resources/',
          data: payload,
          options: Options(
            headers: {
              'Authorization': 'Token $authToken',
            },
          ),
        );
    if (response.statusCode == 200) {
      return ExternalResource.fromJson(response.data);
    } else {
      logger.d('statusCode: ${response.statusCode}');
      return null;
    }
  }
}
