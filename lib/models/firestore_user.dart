class FirestoreUser {
  final String userID;
  final String nickname;
  final String imagePath;
  final bool userHasImage;

  FirestoreUser({
    required this.userID,
    required this.nickname,
    required this.imagePath,
    required this.userHasImage,
  });
}
