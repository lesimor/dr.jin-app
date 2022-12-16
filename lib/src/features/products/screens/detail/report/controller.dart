// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/products/models/product.dart';
import 'package:bookrabbit/src/features/authentication/data/user_respository.dart';
import 'package:bookrabbit/src/features/products/screens/detail/report/repository.dart';

// 리포트 타입을 정의 (모임 또는 유저)
enum ReportType { product, user }

class ReportPageController extends GetxController {
  final ReportPageRepository reportRepository = ReportPageRepository();
  final UserRepository userRepository = UserRepository();
  ReportPageController();

  final _checked = false.obs;
  set checked(value) => this._checked.value = value;
  get checked => this._checked.value;

  final _reportType = Rx<ReportType>(ReportType.product);
  set reportType(value) => this._reportType.value = value;
  get reportType => this._reportType.value;

  void reportProduct(
    ProductDetailModel product,
    String content,
  ) async {
    // 신고 접수.
    await this.reportRepository.reportProduct(product, content);
  }

  void reportUser(
    int userId,
    String content,
  ) async {
    // 신고 접수.
    await UserRepository.reportUser(userId, content);
  }

  void blockUser(
    int targetUserId,
  ) async {
    // 사용자 차단.
    await UserRepository.setRelationship('block', targetUserId);
  }
}
