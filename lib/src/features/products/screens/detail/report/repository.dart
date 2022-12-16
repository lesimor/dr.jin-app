// Project imports:
import 'package:bookrabbit/src/features/products/models/product.dart';
import 'package:bookrabbit/src/common/data/model/response.dart';
import 'package:bookrabbit/src/features/products/data/product_provider.dart';

class ReportPageRepository {
  final ProductProvider productApi = ProductProvider();
  ReportPageRepository();

  Future<CustomApiResponse> reportProduct(
    ProductDetailModel product,
    String content,
  ) {
    return productApi.reportProduct(product, content);
  }
}
