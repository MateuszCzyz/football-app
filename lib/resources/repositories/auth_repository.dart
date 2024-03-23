import 'package:FootballApp/resources/providers/image_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final ImageProvider _imageProvider = ImageProvider();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signInWithGoogle() async {
    GoogleSignInAccount? _googleSignInAccount = await _googleSignIn.signIn();
    if (_googleSignInAccount != null) {
      GoogleSignInAuthentication _googleSignInAuth =
          await _googleSignInAccount.authentication;
      AuthCredential _authCredential = GoogleAuthProvider.credential(
          idToken: _googleSignInAuth.idToken,
          accessToken: _googleSignInAuth.accessToken);
      await _firebaseAuth.signInWithCredential(_authCredential);
    }
  }

  Future<void> createUserWithEmailAndPassoword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> updateUserName({required String displayName}) async {
    if (_firebaseAuth.currentUser != null) {
      await _firebaseAuth.currentUser!.updateDisplayName(displayName);
    }
  }

  Future<void> updateUserEmail({required String email}) async {
    if (_firebaseAuth.currentUser != null) {
      return await _firebaseAuth.currentUser!.updateEmail(email);
    }
  }

  Future<void> updateUserPassword({required String password}) async {
    if (_firebaseAuth.currentUser != null) {
      await _firebaseAuth.currentUser!.updatePassword(password);
    }
  }

  Future<void> setUserPhotoByCamera() async {
    final currentUser = getCurrentUser();
    if (currentUser != null) {
      final photo = await _imageProvider.getCameraPhoto();
      await _imageProvider.uploadImage(
          imageFile: photo!, userID: currentUser.uid);
      final photoUrl =
          await _imageProvider.getUserPhotoUrl(userID: currentUser.uid);
      if (_firebaseAuth.currentUser != null) {
        await _firebaseAuth.currentUser!.updatePhotoURL(photoUrl);
      }
    }
  }

  Future<void> setUserPhotoByGallery() async {
    final currentUser = getCurrentUser();
    if (currentUser != null) {
      String _userID = currentUser.uid;
      PickedFile? _pickedFile = await _imageProvider.getGalleryPhoto();
      if (_pickedFile != null) {
        await _imageProvider.uploadImage(
            imageFile: _pickedFile, userID: _userID);
        String photoURL = await _imageProvider.getUserPhotoUrl(userID: _userID);
        if (_firebaseAuth.currentUser != null) {
          await _firebaseAuth.currentUser!.updatePhotoURL(photoURL);
        }
      }
    }
  }

  Future<void> removeUserPhoto() async {
    User? _user = getCurrentUser();
    if (_user != null) {
      await _user.updatePhotoURL(null);
    }
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  bool isSignedIn() {
    return _firebaseAuth.currentUser != null;
  }

  Future<void> reloadAccount() async {
    if (_firebaseAuth.currentUser != null) {
      await _firebaseAuth.currentUser!.reload();
    }
  }

  Future<void> signOut() async {
    await Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<void> deleteAccount() async {
    if (_firebaseAuth.currentUser != null) {
      return await _firebaseAuth.currentUser!.delete();
    }
  }
}
