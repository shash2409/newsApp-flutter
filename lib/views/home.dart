import 'dart:math';

import 'package:flutter/material.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:newsapp/widgets.dart';
import 'package:newsapp/constants.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _loading;
  int _selected = 0;
  var newsData;

  void getNewsData() async {
    newsData = await NewsModel().getNewsData();
    setState(() {
      _loading = false;
    });
  }

  void getCategoryNewsData(String category) async {
    newsData = await NewsModel().getCategoryNewsData(category);
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;
    super.initState();
    getNewsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 10.0, top: 10.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 34,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _loading = true;
                            _selected = index;
                          });
                          getCategoryNewsData(categories[index]);
                        },
                        child: CategoryTile(
                          categoryName: categories[index],
                          color:
                              _selected == index ? Colors.black26 : Colors.red,
                        ),
                      );
                    }),
              ),
              _loading
                  ? Container(
                      height: MediaQuery.of(context).size.height - 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 16),
                      padding: EdgeInsets.only(right: 10.0),
                      child: ListView.builder(
                          itemCount: newsData.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return NewsTile(
                              imgUrl: newsData[index]["urlToImage"] ?? "",
                              title: newsData[index]["title"] ?? "",
                              desc: newsData[index]["description"] ?? "",
                              content: newsData[index]["content"] ?? "",
                              posturl: newsData[index]["url"] ?? "",
                              publishedAt: newsData[index]["publishedAt"] ?? "",
                            );
                          }),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  CategoryTile({this.categoryName, this.color});
  final String categoryName;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.0),
      height: 34,
      width: 110,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(20.0)),
      child: Center(
        child: Text(
          categoryName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
