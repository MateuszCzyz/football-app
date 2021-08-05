import 'package:FootballApp/resources/providers/image_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final ImageProvider _imageProvider = ImageProvider();

  Future<void> signInWithEmailAndPassword(
      {String email, String password}) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signInWithGoogle() async {
    GoogleSignInAccount _googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _googleSignInAuth =
        await _googleSignInAccount.authentication;
    AuthCredential _authCredential = GoogleAuthProvider.credential(
        idToken: _googleSignInAuth.idToken,
        accessToken: _googleSignInAuth.accessToken);
    await _firebaseAuth.signInWithCredential(_authCredential);
  }

  Future<void> createUserWithEmailAndPassoword(
      {String email, String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> updateUserName({String displayName}) async {
    return await _firebaseAuth.currentUser.updateDisplayName(displayName);
  }

  Future<void> updateUserEmail({String email}) async {
    return await _firebaseAuth.currentUser.updateEmail(email);
  }

  Future<void> updateUserPassword({String password}) async {
    return await _firebaseAuth.currentUser.updatePassword(password);
  }

  Future<void> setUserPhotoByCamera() async {
    String _userID = getCurrentUser().uid;
    PickedFile _pickedFile = await _imageProvider.getCameraPhoto();
    await _imageProvider.uploadImage(imageFile: _pickedFile, userID: _userID);
    String photoURL = await _imageProvider.getUserPhotoUrl(userID: _userID);
    await _firebaseAuth.currentUser.updatePhotoURL(photoURL);
  }

  Future<void> setUserPhotoByGallery() async {
    String _userID = getCurrentUser().uid;
    PickedFile _pickedFile = await _imageProvider.getGalleryPhoto();
    await _imageProvider.uploadImage(imageFile: _pickedFile, userID: _userID);
    String photoURL = await _imageProvider.getUserPhotoUrl(userID: _userID);
    await _firebaseAuth.currentUser.updatePhotoURL(photoURL);
  }

  Future<void> removeUserPhoto() async {
    User _user = getCurrentUser();
    await _user.updatePhotoURL(null);
  }

  User getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  bool isSignedIn() {
    return _firebaseAuth.currentUser != null;
  }

  Future<void> reloadAccount() async {
    return await _firebaseAuth.currentUser.reload();
  }

  Future<void> signOut() async {
    return await Future.wait(
        [_firebaseAuth.signOut(), _googleSignIn.signOut()]);
  }

  Future<void> deleteAccount() async {
    return await _firebaseAuth.currentUser.delete();
  }
}
