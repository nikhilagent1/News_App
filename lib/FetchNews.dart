import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/NewsArt.dart';

class FetchNews {
  static List sourcesId = [
    "abc-news",
    "bbc-news",
    "bbc-sport",
    "business-insider",
    "engadget",
    "entertainment-weekly",
    "espn",
    "espn-cric-info",
    "financial-post",
    "fox-news",
    "fox-sports",
    "globo",
    "google-news",
    "google-news-in",
    "medical-news-today",
    "national-geographic",
    "news24",
    "new-scientist",
    "new-york-magazine",
    "next-big-future",
    "techcrunch",
    "techradar",
    "the-hindu",
    "the-wall-street-journal",
    "the-washington-times",
    "time",
    "usa-today",
  ];
  static Future<NewsArt> fetchNews() async {
    final _random = new Random();
    var sourceId = sourcesId[_random.nextInt(sourcesId.length)];
    print('------------------------------------------------------------');
    print(sourceId);
    print('------------------------------------------------------------');
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?sources=${sourceId}&apiKey=91142a41caf54951a13da75e52328ec0");
    var response = await http.get(url);
    print('Response Status code = ${response.statusCode}');
    print("Response body ${response.body}");
    Map body_data = jsonDecode(response.body);

    print(
        "///////////////////////////////////////////////////////////////////");
    print(body_data);
    print(
        "///////////////////////////////////////////////////////////////////");
    List articles = body_data["articles"];
    final _Newrandom = new Random();
    var myArticle = articles[_random.nextInt(articles.length)];
    print("***************************************************************");
    print(myArticle);
    print("***************************************************************");
    return NewsArt.fromAPItoApp(myArticle);
  }
}
