class FirestoreUser {
  final String userID;
  final String nickname;
  final String imagePath;
  final bool userHasImage;

  FirestoreUser(
      {this.userID, this.nickname, this.imagePath, this.userHasImage});
}
