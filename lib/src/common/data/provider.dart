// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:bookrabbit/src/features/authentication/controllers/auth_controller.dart';
import 'package:bookrabbit/src/common/data/model/pagination.dart';
import 'package:bookrabbit/src/utils/dio_client.dart';
import 'package:bookrabbit/src/utils/logger.dart';

// TODO: DEPRECATED
class ResourceProvider<T> {
  final String resourceName;
  final T Function(dynamic)? elementFromJson;
  final Map<String, dynamic> Function(T)? elementToJson;

  ResourceProvider({
    required this.resourceName,
    this.elementFromJson,
    this.elementToJson,
  });

  Future<PaginatedResult<T>?> getPaginatedResult(
    PaginationFilter filter,
  ) async {
    var authToken = await AuthController.getToken();
    var response = await DioClient().dio.get(
          '/api/db/${resourceName}/',
          queryParameters: {'page': filter.page, 'page_size': filter.pageSize},
          options: Options(
            headers: {
              'Authorization': 'Token $authToken',
            },
          ),
        );
    if (response.statusCode == 200) {
      return PaginatedResult<T>.fromJson(response.data, elementFromJson!);
    } else {
      logger.d('statusCode: ${response.statusCode}');
      return null;
    }
  }

  Future<int?> create(T element) async {
    var authToken = await AuthController.getToken();
    var response = await DioClient().dio.post(
          '/api/db/${resourceName}/',
          data: elementToJson!(element),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Token $authToken',
            },
          ),
        );

    if (response.statusCode == 201) {
      return response.data['id'];
    } else {
      return null;
    }
  }

  Future<int?> put(T element, int id) async {
    var authToken = await AuthController.getToken();
    var response = await DioClient().dio.put(
          '/api/db/${resourceName}/${id}/',
          data: elementToJson!(element),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Token $authToken',
            },
          ),
        );

    if (response.statusCode == 200) {
      return response.data['id'];
    } else {
      return null;
    }
  }

  Future<T?> getById(int id) async {
    var authToken = await AuthController.getToken();
    var response = await DioClient().dio.get(
          '/api/db/${resourceName}/${id}/',
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Token $authToken',
            },
          ),
        );

    if (response.statusCode == 200) {
      return this.elementFromJson!(response.data);
    } else {
      throw "API error";
    }
  }

  Future<void> deleteById(int id) async {
    var authToken = await AuthController.getToken();
    await DioClient().dio.delete(
          '/api/db/${resourceName}/${id}/',
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Token $authToken',
            },
          ),
        );
  }
}

class ResourceProviderV2<IN, OUT> {
  final String resourceName;
  final OUT Function(dynamic)? elementFromJson;
  final Map<String, dynamic> Function(IN)? elementToJson;
  final Map<String, String>? headers;

  ResourceProviderV2({
    required this.resourceName,
    this.elementFromJson,
    this.elementToJson,
    this.headers,
  });

  String generateUrl(resourceName) {
    return '/${resourceName}/';
  }

  Future<Map<String, String>> generateHeader() async {
    var authToken = await AuthController.getToken();
    var userType = await AuthController.getUserType();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
      'x-user-type': '$userType',
    };
    // headers.addAll(this.headers ?? {});
    return headers;
  }

  getList() async {
    var response = await DioClient().dio.get(
          generateUrl(resourceName),
          options: Options(
            headers: await generateHeader(),
          ),
        );
    return response.data.map<OUT>((e) => elementFromJson!(e)).toList();
  }

  Future<OUT?> create(IN element) async {
    var response = await DioClient().dio.post(
          generateUrl(resourceName),
          data: elementToJson!(element),
          options: Options(
            headers: await generateHeader(),
          ),
        );

    if (response.statusCode == 201) {
      return response.data['id'];
    } else {
      return null;
    }
  }

  Future<int?> put(IN element, int id) async {
    var response = await DioClient().dio.put(
          '${generateUrl(resourceName)}/${id}/',
          data: elementToJson!(element),
          options: Options(
            headers: await generateHeader(),
          ),
        );

    if (response.statusCode == 200) {
      return response.data['id'];
    } else {
      return null;
    }
  }

  Future<OUT?> getById(String id) async {
    var response = await DioClient().dio.get(
          '${generateUrl(resourceName)}/${id}/',
          options: Options(
            headers: await generateHeader(),
          ),
        );

    if (response.statusCode == 200) {
      return this.elementFromJson!(response.data);
    } else {
      throw "API error";
    }
  }

  Future<void> deleteById(String id) async {
    await DioClient().dio.delete(
          '${generateUrl(resourceName)}/${id}',
          options: Options(
            headers: await generateHeader(),
          ),
        );
  }
}
