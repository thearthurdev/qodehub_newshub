import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:qodehub_newshub/models/news_article_model.dart';
import 'package:qodehub_newshub/pages/details_page.dart';

class ArticleTile extends StatelessWidget {
  final NewsArticle _article;

  const ArticleTile(this._article);

  @override
  Widget build(BuildContext context) {
    // Returning OpenContainer to use listTile transition animations
    // recommended by flutter team
    return OpenContainer(
      closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      closedBuilder: (context, action) {
        // ShowUp widget animates its child when rendering to make it 'show up'
        // ShowUp direction can be changed as desired
        return Hero(
          tag: _article.title,
          child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
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
            trailing: Icon(Icons.chevron_right),
          ),
        );
      },
      openBuilder: (context, action) {
        // Opens Details page when ListTile is tapped
        return DetailsPage(_article);
      },
    );
  }
}
