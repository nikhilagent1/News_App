import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/FetchNews.dart';
import 'package:news_app/LoginPage.dart';
import 'package:news_app/NewsArt.dart';
import 'package:news_app/NewsPage.dart';
import 'dart:ui';

import 'package:news_app/SideBar.dart';

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  //------------------------------------------------------variables
  NewsArt? newsArt;
  bool isLoading = true;
  //---------------------------------------------------------functions
  GetNews() async {
    newsArt = await FetchNews.fetchNews();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> logout() async {
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    GetNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
          backgroundColor: Colors.yellow[300],
          title: Text(
            'NEWS App',
            style: TextStyle(color: Colors.deepPurple),
          ),
          actions: [
            Container(
              child: IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  logout();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                      ((route) => false));
                },
                icon: Icon(Icons.logout_outlined),
              ),
            ),
          ]),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : newsArt == null
              ? Center(child: Text('Failure'))
              : Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          // itemCount: 10,
                          onPageChanged: (value) {
                            GetNews();
                          },
                          itemBuilder: (context, index) {
                            // FetchNews.fetchNews();

                            return ListView(children: [
                              Center(
                                child: NewsPage(
                                    url: newsArt!.url,
                                    newsHead: newsArt!.newsHead,
                                    newsDes: newsArt!.newsDes,
                                    cnt: newsArt!.cnt,
                                    newsUrl: newsArt!.newsUrl),
                              )
                            ]);
                          }),
                    ),
                  ],
                ),
    );
  }
}
