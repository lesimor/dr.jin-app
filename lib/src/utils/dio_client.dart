// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:bookrabbit/environment.dart';
import 'package:bookrabbit/src/common/widgets/toast.dart';
import 'package:bookrabbit/src/utils/logger.dart';

// Reference: https://www.reddit.com/r/FlutterDev/comments/d2tnsl/usage_of_dio_in_flutter/
class DioClient {
  static BaseOptions baseOptions = BaseOptions(
    baseUrl:
        "${Environment().config.tcpProtocol}://${Environment().config.apiHost}",
  );

  static final DioClient _dioClient = DioClient._internal();

  // 싱글턴 객체.
  Dio _dio = new Dio(baseOptions);
  Dio get dio => _dio;
  factory DioClient() {
    return _dioClient;
  }
  DioClient._internal() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioError e, handler) {
          if (e.response?.statusCode == 401) {
            showToast(message: '로그인이 필요합니다.');
          } else {
            showToast(
              message: '네트워크 통신중 에러가 발생했습니다.',
              messageType: MessageType.alert,
            );
          }

          return handler.next(e);
        },
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: true,
        responseHeader: true,
        request: true,
        requestBody: true,
        logPrint: logger.d,
      ),
    );
  }
}
