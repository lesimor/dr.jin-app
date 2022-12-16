// Package imports:
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingController extends GetxController {
  SettingController();

  Rx<String> _version = ''.obs;
  Rx<String> _buildNumber = ''.obs;

  get version => _version.value;
  get buildNumber => _buildNumber.value;

  @override
  void onInit() {
    fetchAppMeta();
    super.onInit();
  }

  void fetchAppMeta() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _version.value = packageInfo.version;
    _buildNumber.value = packageInfo.buildNumber;
  }

  
}
