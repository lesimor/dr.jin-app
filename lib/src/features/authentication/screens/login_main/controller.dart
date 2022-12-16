// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/authentication/screens/login_main/repository.dart';

class ModelTemplateController extends GetxController {
  final ModuleTemplateRepository repository = ModuleTemplateRepository();
  ModelTemplateController();

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}
