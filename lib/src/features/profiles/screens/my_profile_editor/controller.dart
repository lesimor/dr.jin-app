// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// Project imports:
import 'package:bookrabbit/src/features/authentication/controllers/auth_controller.dart';
import 'package:bookrabbit/src/features/authentication/models/user.dart';
import 'package:bookrabbit/src/features/authentication/data/auth_repository.dart';
import 'package:bookrabbit/src/features/authentication/data/user_respository.dart';
import 'package:bookrabbit/src/utils/image_uploader.dart';

class ProfileEditorController extends GetxController with StateMixin {
  static ProfileEditorController get to => Get.find();

  ProfileEditorController();

  final _isLoading = false.obs;
  get isLoading => this._isLoading.value;

  final _imageUrl = Rx<String?>(null);
  set imageUrl(value) => this._imageUrl.value = value;
  get imageUrl => this._imageUrl.value;

  final TextEditingController nicknameCon = TextEditingController();
  final _nicknameInputLength = 0.obs;
  set nicknameInputLength(value) => this._nicknameInputLength.value = value;
  get nicknameInputLength => this._nicknameInputLength;

  final TextEditingController introductionCon = TextEditingController();
  final _introductionInputLength = 0.obs;
  set introductionInputLength(value) =>
      this._introductionInputLength.value = value;
  get introductionInputLength => this._introductionInputLength;

  @override
  void onInit() {
    // 입력값 컨트롤러 동기화
    var currentUser = AuthController.to.currentUser;
    nicknameCon.text = currentUser!.username;
    introductionCon.text = currentUser.introduction;

    // 상태 컨트롤러 동기화
    initWithCurrentUser(AuthController.to.currentUser!);

    super.onInit();

    // 우선 success로 초기화.
    change(null, status: RxStatus.success());
  }

  initWithCurrentUser(UserDetailModel currentUser) {
    imageUrl = currentUser.profileThumbnail;
    nicknameInputLength = currentUser.username.length;
  }

  Future<void> changeUserInfo() async {
    var token = await AuthRepository.getAuthorizedToken();

    dynamic payload = {};

    payload['nickname'] = nicknameCon.text;
    payload['profile_thumbnail'] = imageUrl;
    payload['introduction'] = introductionCon.text;

    await UserRepository.patchCurrentUserInfo(
      token,
      payload,
    );
  }

  Future pickImage({ImageSource source = ImageSource.gallery}) async {
    return ImageUploader().pickImage(
      source: source,
      progressFunction: (progress) {
        switch (progress) {
          case ImageUploadProgress.onPregress:
            {
              change(imageUrl, status: RxStatus.loading());
              this._isLoading.value = true;
            }
            break;

          case ImageUploadProgress.done:
            {
              this._isLoading.value = false;
              change(imageUrl, status: RxStatus.success());
            }
            break;
          case ImageUploadProgress.error:
            {
              this._isLoading.value = false;
              change(imageUrl, status: RxStatus.error());
            }
            break;
        }
      },
    );
  }
}
