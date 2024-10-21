import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AppUtil {
  AppUtil._();

  static Future<File?> pickImage(ImageSource source) async {
    try {
      final permissionStatus = await _requestPermission(source);
      if (permissionStatus.isGranted) {
        final image = await ImagePicker()
            .pickImage(source: source, imageQuality: 100, maxWidth: 1920);
        if (image == null) return null;
        final imageTemp = File(image.path);
        return await cropImage(imageTemp);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<PermissionStatus> _requestPermission(ImageSource source) async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      if (source == ImageSource.gallery) {
        return int.parse(androidInfo.version.release) > 12
            ? await Permission.photos.request()
            : await Permission.storage.request();
      } else if (source == ImageSource.camera) {
        return Permission.camera.request();
      }
    }

    return PermissionStatus.granted;
  }

  static Future<File?> cropImage(File image) async {
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(lockAspectRatio: true),
      ],
    );
    return croppedImage != null ? File(croppedImage.path) : null;
  }

  static Future<File?> pickImageFromGallery() => pickImage(ImageSource.gallery);

  static Future<File?> pickImageFromCamera() => pickImage(ImageSource.camera);
}
