// Dart imports:
import 'dart:io';

// Package imports:
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// Project imports:
import 'package:bookrabbit/src/utils/logger.dart';

enum ImageUploadProgress { onPregress, done, error }

class ImageUploader {
  final ImagePicker _picker = ImagePicker();
  final ImageCropper _cropper = ImageCropper();

  ImageUploader();

  Future pickImage({
    ImageSource source = ImageSource.gallery,
    void Function(ImageUploadProgress)? progressFunction,
    double? xyRatio,
  }) async {
    try {
      final pickedFile =
          await _picker.pickImage(source: source, imageQuality: 50);
      if (pickedFile == null) {
        return;
      }

      var file = await _cropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: xyRatio ?? 1),
      );
      if (file == null) {
        return;
      }

      var compressedFile = await compressImage(file.path, 35);

      if (progressFunction != null)
        progressFunction(ImageUploadProgress.onPregress);

      var firebaseImageUrl = await _uploadFile(compressedFile!.path);
      if (progressFunction != null) progressFunction(ImageUploadProgress.done);
      return firebaseImageUrl;
    } on Exception catch (e) {
      logger.e(e);
      if (progressFunction != null) progressFunction(ImageUploadProgress.error);
      return;
    }
  }

  Future<File?> compressImage(String path, int quality) async {
    final newPath = p.join(
      (await getTemporaryDirectory()).path,
      "${DateTime.now()}.${p.extension(path)}",
    );

    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      newPath,
      quality: quality,
    );

    return result;
  }

  Future _uploadFile(String path) async {
    final ref = storage.FirebaseStorage.instance
        .ref()
        .child('images')
        .child("${DateTime.now().toIso8601String() + p.basename(path)}");

    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();

    return fileUrl;
  }
}
