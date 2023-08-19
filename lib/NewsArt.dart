class NewsArt {
  String url;
  String newsHead;
  String newsDes;
  String cnt;
  String newsUrl;

  NewsArt({
    required this.url,
    required this.cnt,
    required this.newsDes,
    required this.newsHead,
    required this.newsUrl,
  });
  static NewsArt fromAPItoApp(Map<String, dynamic> article) {
    return NewsArt(
        url: article["urltoImage"] ??
            "https://media.istockphoto.com/id/160759395/vector/emoticon-with-newspaper.jpg?s=612x612&w=0&k=20&c=XcLbYABSyrk9DLx0DxAVqcM1bAtO5Wle1o5zZ0utbi0=",
        cnt: article["content"] ?? "--",
        newsDes: article["description"] ?? "--",
        newsHead: article["title"] ?? "--",
        newsUrl: article["url"] ?? "https://www.aajtak.in/");
  }
}
