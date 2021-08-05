import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ImageProvider {
  ImagePicker _imagePicker = ImagePicker();
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<PickedFile> getCameraPhoto() async {
    return _imagePicker.getImage(source: ImageSource.camera);
  }

  Future<PickedFile> getGalleryPhoto() async {
    return _imagePicker.getImage(source: ImageSource.gallery);
  }

  Future<String> getUserPhotoUrl({String userID}) async {
    String id = await _firebaseStorage.ref(userID).getDownloadURL();
    return id;
  }

  Future<void> uploadImage({String userID, PickedFile imageFile}) async {
    File _file = File(imageFile.path);
    await _firebaseStorage.ref().child(userID).putFile(_file);
  }

  Future<void> removeImage({String userID}) async {
    try {
      await _firebaseStorage.ref(userID).delete();
    } catch (e) {
      print('user does not have an image');
    }
  }

  Future<String> saveBookmarkedImage(String imageURL) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/${DateTime.now()}.jpg');
    var request = await http.get(Uri.parse(imageURL));
    var bytes = request.bodyBytes;
    await file.writeAsBytes(bytes);
    return file.path;
  }
}
