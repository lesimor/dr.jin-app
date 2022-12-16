// Package imports:
import 'package:bookrabbit/src/common/data/provider.dart';
import 'package:bookrabbit/src/common/data/respository.dart';
import 'package:bookrabbit/src/features/contents/data/club_provider.dart';
import 'package:bookrabbit/src/features/products/models/content.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/contents/screens/club_list/repository.dart';

class ClubListPageController extends GetxController with StateMixin {
  ClubListPageController();
  final resourceRepository = ResourceRepository();
  ResourceProviderV2<ContentInModel, ContentOutModel> get contentApi =>
      resourceRepository.contentApi;

  final ClubListRepository repository = ClubListRepository();
  final ClubProvider clubApi = ClubProvider();

  // 클럽 리스트
  final _contentList = <ContentOutModel>[].obs;
  get contentList => this._contentList;
  set contentList(value) => this._contentList.value = value;

  @override
  onInit() {
    fetchContents();
    super.onInit();
  }

  fetchContents() async {
    change(null, status: RxStatus.loading());
    try {
      this.contentList = await this.contentApi.getList();
      change(null, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
