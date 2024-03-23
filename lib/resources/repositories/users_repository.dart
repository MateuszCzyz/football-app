import 'package:FootballApp/models/firestore_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<FirestoreUser>> getUsersList() async {
    List<FirestoreUser> _users = <FirestoreUser>[];
    QuerySnapshot _querySnapshot = await _firestore.collection('users').get();
    for (QueryDocumentSnapshot doc in _querySnapshot.docs) {
      Map<String, dynamic> _data = doc.data();
      _users.add(FirestoreUser(
          userID: _data['id_user'],
          nickname: _data['user_name'],
          imagePath: _data['image_path'],
          userHasImage: _data['user_has_image']));
    }
    return _users;
  }

  FirestoreUser getUserData({
    required List<FirestoreUser> users,
    required String userID,
  }) {
    return users.firstWhere((_firestoreUser) {
      if (_firestoreUser.userID == userID)
        return true;
      else
        return false;
    });
  }

  Future<String> getUserDocumentID({required String userID}) async {
    QuerySnapshot _querySnapshot = await _firestore
        .collection('users')
        .where('id_user', isEqualTo: userID)
        .get();
    return _querySnapshot.docs[0].id;
  }

  Future<bool> userExists({required String userID}) async {
    try {
      await getUserDocumentID(userID: userID);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> updateUserPhoto({
    required String userID,
    required String newImagePath,
  }) async {
    String docID = await getUserDocumentID(userID: userID);
    await _firestore
        .collection('users')
        .doc(docID)
        .update({'image_path': newImagePath, 'user_has_image': true});
  }

  Future<void> updateUserName({
    required String userID,
    required String newUserName,
  }) async {
    String docID = await getUserDocumentID(userID: userID);
    await _firestore
        .collection('users')
        .doc(docID)
        .update({'user_name': newUserName});
  }

  Future<void> removeUserPhoto({required String userID}) async {
    String docID = await getUserDocumentID(userID: userID);
    await _firestore
        .collection('users')
        .doc(docID)
        .update({'image_path': null, 'user_has_image': false});
  }

  Future<void> removeUser({required String userID}) async {
    String docID = await getUserDocumentID(userID: userID);
    await _firestore.collection('users').doc(docID).delete();
  }

  Future<void> createUser({
    required String userID,
    required String userName,
  }) async {
    await _firestore.collection('users').add({
      'id_user': userID,
      'image_path': null,
      'user_has_image': false,
      'user_name': userName
    });
  }
}
