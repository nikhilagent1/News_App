import 'dart:convert';

import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  String url;
  String newsHead;
  String newsDes;
  String cnt;
  String newsUrl;
  NewsPage(
      {super.key,
      required this.url,
      required this.newsHead,
      required this.newsDes,
      required this.cnt,
      required this.newsUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          // Image.asset("Images/Login.jpg"),
          Image(
            image: NetworkImage(url),
            height: 300,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(newsHead, style: TextStyle(color: Colors.deepPurple)),
                Text(newsDes, style: TextStyle(color: Colors.deepPurple)),
                Text(cnt, style: TextStyle(color: Colors.deepPurple)),
              ],
            ),
          ),

          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
              onPressed: () {
                print("Read More");
              },
              child: Text("Read More", style: TextStyle(color: Colors.white)))
        ]));
  }
}
