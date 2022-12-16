// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/_getx_template/repository.dart';

class TemplatePageController extends GetxController with StateMixin {
  final ModuleTemplateRepository repository = ModuleTemplateRepository();
  TemplatePageController();

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;

  final _users = [].obs;

  get userList => this._users;
  set userList(value) => this._users.value = value;

  get users => this._users;

  @override
  onInit() {
    getData();
    super.onInit();
  }

  getData() {
    change(null, status: RxStatus.loading());
    change(null, status: RxStatus.success());
  }
}
