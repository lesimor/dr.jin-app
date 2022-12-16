// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/products/models/participation.dart';
import 'package:bookrabbit/src/features/products/models/payment.dart';
import 'package:bookrabbit/src/features/products/models/product.dart';
import 'package:bookrabbit/src/features/authentication/models/user.dart';
import 'package:bookrabbit/src/common/data/provider.dart';
import 'package:bookrabbit/src/common/data/respository.dart';
import 'package:bookrabbit/src/features/products/screens/detail/repository.dart';

class ProductViewerController extends GetxController
    with GetTickerProviderStateMixin {
  final resourceRepository = ResourceRepository();
  ResourceProvider<ProductDetailModel> get productMutator =>
      resourceRepository.productMutationApi;

  ResourceProvider<ParticipationModel> get participationApi =>
      resourceRepository.participationApi;

  final ProductViewerRepository repository = ProductViewerRepository();
  ProductViewerController();

  Rx<bool> _isLoading = true.obs;
  Rx<bool> _isLiked = false.obs;
  Rx<bool> _isCreator = false.obs;
  Rx<bool> _isParticipated = false.obs;
  Rx<bool> _isOutDated = false.obs;
  Rx<bool> _isFull = false.obs;
  Rx<bool> _isFreeProduct = false.obs;
  Rx<ProductDetailModel?> _product = Rx<ProductDetailModel?>(null);
  Rx<PaymentModel> _payment = PaymentModel().obs;

  get isLoading => this._isLoading.value;
  get isLiked => this._isLiked.value;
  get isCreator => this._isCreator.value;
  get isParticipated => this._isParticipated.value;
  get isOutDated => this._isOutDated.value;
  get isFull => this._isFull.value;
  get isFreeProduct => this._isFreeProduct.value;
  get product => this._product.value;
  get payment => this._payment.value;

  get applyNotAllowed => this.isFull || this.isOutDated;

  fetchProduct({int id = 1}) async {
    try {
      _isLoading(true);
      this._product.value = await this.productMutator.getById(id);
      this._isFreeProduct.value = this.product.price! <= 0;
      this._isOutDated.value = this.product.datetime.isBefore(DateTime.now());
      this._isFull.value = this.product.participantsNumber! <=
          this.product.totalMemberIds!.length;
    } finally {
      _isLoading(false);
      return this._product.value;
    }
  }

  Future<void> refresh() async {
    await fetchProduct(id: this.product.id);
  }

  Future<void> deleteProduct() async {
    // 모임 삭제.
    return productMutator.deleteById(this.product.id);
  }

  void deleteParticipation(int id) async {
    // 참여자를 제외한다.
    await participationApi.deleteById(id);
    await refresh();
  }

  initUserStatus(UserDetailModel user) {
    // 좋아요 여부
    this._isLiked.value =
        this.product.likes.where((element) => element == user.id).isNotEmpty;

    // 참여중 상태
    var totalMemberId = this.product.totalMemberIds ?? [];
    var result = totalMemberId.where((element) => element == user.id);
    this._isParticipated.value = result.isNotEmpty;

    // 수정 가능 여부
    this._isCreator.value = user.id == product.creator.id;
  }

  set isParticipated(value) => this._isParticipated.value = value;
  set isLiked(value) => this._isLiked.value = value;

  Future fetchMerchantId(ProductDetailModel product) async {
    await this.repository.issueMerchantId(product);
  }
}
