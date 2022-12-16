// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/authentication/screens/registration/repository.dart';

class RegistrationController extends GetxController {
  final RegistrationRepository repository = RegistrationRepository();
  RegistrationController();

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}
