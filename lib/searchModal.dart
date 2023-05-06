class SearchResult {
  final String title;
  final String link;
  final String snippet;

  SearchResult(
      {required this.title, required this.link, required this.snippet});

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      title: json['title'],
      link: json['link'],
      snippet: json['snippet'],
    );
  }
}
