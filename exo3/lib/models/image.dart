class Image {
  late String url;

  Image(this.url);

  Image.fromMap(Map<String, dynamic> json) {
    url = json['url'];
  }
}