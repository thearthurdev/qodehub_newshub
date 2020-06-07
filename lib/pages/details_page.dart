import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qodehub_newshub/models/news_article_model.dart';

class DetailsPage extends StatelessWidget {
  final NewsArticle _article;

  const DetailsPage(this._article);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: Text(_article.title),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.chevron_left, size: 32.0),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              buildArticleImage(),
              buildArticleHeading(),
              buildArticleBody(),
            ],
          ),
        ),
      ),
    );
  }

  Container buildArticleImage() {
    return Container(
      width: double.infinity,
      height: 260.0,
      color: Colors.grey[300],
      // Check if article has image and change child accordingly
      child: _article.image == null || _article.image == ''
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  _article.publisher,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[350],
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          : FittedBox(
              fit: BoxFit.fill,
              // Using a gif placeholder while network image loads
              // loaded image fades in rather than jumping out
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/shimmer.gif',
                image: _article.image,
              ),
            ),
    );
  }

  Widget buildArticleHeading() {
    return Hero(
      tag: _article.id,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        title: Text(
          _article.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(_article.publisher),
        ),
      ),
    );
  }

  Widget buildArticleBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        _article.text,
        style: TextStyle(
          fontSize: 16.0,
          height: 1.5,
        ),
      ),
    );
  }
}
