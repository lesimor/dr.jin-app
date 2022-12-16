// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:bookrabbit/src/features/authentication/controllers/auth_controller.dart';
import 'package:bookrabbit/src/features/products/models/payment.dart';
import 'package:bookrabbit/src/features/products/models/product.dart';
import 'package:bookrabbit/src/utils/dio_client.dart';
import 'package:bookrabbit/src/utils/logger.dart';

class PaymentProvider {
  PaymentProvider();

  Future<PaymentModel?> getMerchantUID(ProductDetailModel product) async {
    var authToken = await AuthController.getToken();
    var response = await DioClient().dio.get(
          '/api/payments/publish',
          queryParameters: {
            'product_id': product.id,
          },
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Token $authToken',
            },
          ),
        );

    if (response.statusCode == 200) {
      logger.d('Payment: ${response.data}');
      return PaymentModel.fromJson(response.data);
    } else {
      throw "Payment API error";
    }
  }

  Future<void> completePayment(Map<String, String> result) async {
    var authToken = await AuthController.getToken();
    var response = await DioClient().dio.get(
          '/api/payments/complete/default/',
          queryParameters: {
            'imp_uid': result["imp_uid"],
            'merchant_uid': result["merchant_uid"],
          },
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Token $authToken',
            },
          ),
        );

    if (response.statusCode != 200) {
      throw 'Error occurred while requesting payment complete API';
    }
  }
}
