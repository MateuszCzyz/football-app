class Video {
  String title;
  String competition;
  String image;
  String date;
  String url;

  Video({this.title, this.competition, this.image, this.date, this.url});

  Video.fromMap(Map<dynamic, dynamic> map) {
    this.title = map['title'];
    this.competition = map['competition'];
    this.image = map['image'];
    this.date = map['date'];
    this.url = map['url'];
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'title': title,
      'competition': competition,
      'image': image,
      'date': date,
      'url': url
    };
  }
}
