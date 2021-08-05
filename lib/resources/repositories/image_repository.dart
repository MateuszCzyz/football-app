import 'package:FootballApp/resources/providers/image_provider.dart';
import 'package:image_picker/image_picker.dart';

class ImageRepository {
  ImageProvider _imageProvider = ImageProvider();

  Future<PickedFile> getCameraPhoto() async {
    return await _imageProvider.getCameraPhoto();
  }

  Future<PickedFile> getGalleryPhoto() async {
    return await _imageProvider.getGalleryPhoto();
  }

  Future<String> getUserPhotoURL({String userID}) async {
    return await _imageProvider.getUserPhotoUrl(userID: userID);
  }

  Future<void> uploadImage({String userID, PickedFile imageFile}) async {
    await _imageProvider.uploadImage(userID: userID, imageFile: imageFile);
  }

  Future<void> removeImage({String userID}) async {
    await _imageProvider.removeImage(userID: userID);
  }
}
