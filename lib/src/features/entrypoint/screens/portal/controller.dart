// Package imports:
import 'package:bookrabbit/src/features/authentication/models/user.dart';
import 'package:bookrabbit/src/features/products/models/content.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/contents/models/club.dart';
import 'package:bookrabbit/src/features/products/models/product.dart';
import 'package:bookrabbit/src/features/products/models/resource.dart';
import 'package:bookrabbit/src/common/data/provider.dart';
import 'package:bookrabbit/src/common/data/respository.dart';

import 'package:bookrabbit/src/features/products/data/product_provider.dart';

class HomePageController extends GetxController with StateMixin {
  HomePageController();
  final resourceRepository = ResourceRepository();
  ResourceProvider<ExternalResource> get externalResourceProvider =>
      resourceRepository.resourceApi;
  ResourceProvider<ProductSummaryModel> get productProvider =>
      ProductProvider();
  ResourceProvider<ClubModel> get clubProvider => resourceRepository.clubApi;
  ResourceProviderV2<UserInModel, UserOutModel> get couselorProvider =>
      resourceRepository.counselorApi;
  ResourceProviderV2<ContentInModel, ContentOutModel> get contentProvider =>
      resourceRepository.contentApi;

  // 상담사 리스트
  final _counselors = <UserOutModel>[].obs;
  get counselors => this._counselors;
  set counselors(value) => this._counselors.value = value;

  // 상담 컨텐츠 리스트
  final _contents = <ContentOutModel>[].obs;
  get contents => this._contents;
  set contents(value) => this._contents.value = value;

  // 도서 순위 관련 데이터
  final _bookRankings = <ExternalResource>[].obs;
  get bookRankings => this._bookRankings;
  set bookRankings(value) => this._bookRankings.value = value;

  // 독서모임 관련 데이터
  final _bookDayProducts = <ProductSummaryModel>[].obs;
  get bookDayProductList => this._bookDayProducts;
  set bookDayProductList(value) => this._bookDayProducts.value = value;

  // 북클럽 관련 데이터
  final _bookclubList = <ContentOutModel>[].obs;
  get bookClubList => this._bookclubList;
  set bookClubList(value) => this._bookclubList.value = value;

  @override
  onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    // make status to loading
    change(null, status: RxStatus.loading());
    // make it parellel
    // TODO: 사용자 리스트 API연동하기
    try {
      var couselorList = await this.couselorProvider.getList();
      this.counselors = couselorList.sublist(0, 3);

      var contentList = await this.contentProvider.getList();
      this.contents = contentList.sublist(0, 4);
      change(null, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
