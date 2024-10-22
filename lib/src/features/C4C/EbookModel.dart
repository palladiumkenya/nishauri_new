class Ebook {
  final String title;
  final String url;

  Ebook({required this.title, required this.url});

  // A factory constructor to create an instance from a map (e.g., JSON)
  factory Ebook.fromJson(Map<String, dynamic> json) {
    return Ebook(
      title: json['title'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
