// Project imports:
import 'package:bookrabbit/src/features/products/models/participation.dart';
import 'package:bookrabbit/src/features/products/models/payment.dart';
import 'package:bookrabbit/src/features/products/models/product.dart';
import 'package:bookrabbit/src/common/data/model/response.dart';
import 'package:bookrabbit/src/features/products/data/payment_provider.dart';
import 'package:bookrabbit/src/features/products/data/product_provider.dart';

class ProductViewerRepository {
  final ProductProvider productApi = ProductProvider();
  final PaymentProvider paymentApi = PaymentProvider();

  ProductViewerRepository();

  Future<CustomApiResponse<dynamic>> likeProduct(ProductDetailModel product) {
    return productApi.likeProduct(product);
  }

  Future<CustomApiResponse<dynamic>> unlikeProduct(
    ProductDetailModel product,
  ) {
    return productApi.unlikeProduct(product);
  }

  Future<ParticipationModel> participateFreeProduct(
    ProductDetailModel product,
  ) {
    return productApi.participateFreeProduct(product);
  }

  Future<PaymentModel?> issueMerchantId(ProductDetailModel product) {
    return paymentApi.getMerchantUID(product);
  }
}
