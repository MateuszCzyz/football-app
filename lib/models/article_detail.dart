class ArticleDetail {
  String id;
  String author;
  List<dynamic> content;

  ArticleDetail({this.author, this.content, this.id});

  ArticleDetail.fromMap(Map<dynamic, dynamic> json) {
    this.author = json['id'];
    this.author = json['author'];
    this.content = json['content'];
  }

  Map<dynamic, dynamic> toMap() {
    return {'id': this.id, 'author': this.author, 'content': this.content};
  }
}
