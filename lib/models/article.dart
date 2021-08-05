class Article {
  String id;
  String title;
  String image;
  String slug;
  String date;
  String url;

  Article({this.id, this.title, this.date, this.image, this.slug, this.url});

  Article.fromMap(Map<dynamic, dynamic> json) {
    this.id = json['id'];
    this.title = json['title'];
    this.image = json['image'];
    this.slug = json['slug'];
    this.date = json['date'];
    this.url = json['url'];
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'slug': slug,
      'date': date,
      'url': url
    };
  }
}
