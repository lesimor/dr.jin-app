// Project imports:
import 'package:bookrabbit/src/features/products/models/product.dart';

class PaymentModel {
  String? uid;
  String? state;
  int? amount;
  ProductSummaryModel? product;
  int? user;

  PaymentModel({
    this.uid,
    this.state,
    this.amount,
    this.product,
    this.user,
  });

  PaymentModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    state = json['state'];
    amount = json['amount'];
    // product = json['product'] != null
    //     ? new ProductModel.fromJson(json['product'])
    //     : null;
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['state'] = this.state;
    data['amount'] = this.amount;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['user'] = this.user;
    return data;
  }
}
