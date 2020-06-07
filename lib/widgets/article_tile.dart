import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:qodehub_newshub/models/news_article_model.dart';
import 'package:qodehub_newshub/pages/details_page.dart';
import 'package:qodehub_newshub/widgets/show_up_widget.dart';

class ArticleTile extends StatelessWidget {
  final NewsArticle article;
  final int index;

  const ArticleTile({this.article, this.index});

  @override
  Widget build(BuildContext context) {
    // Returning OpenContainer to use listTile transition animations
    // recommended by flutter team
    return OpenContainer(
      closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      closedBuilder: (context, action) {
        // ShowUp widget animates its child when rendering to make it 'show up'
        // ShowUp direction can be changed as desired
        return ShowUp(
          delay: 100 * index,
          child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            title: Text(
              article.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(article.publisher),
            ),
            trailing: Icon(Icons.chevron_right),
          ),
        );
      },
      openBuilder: (context, action) {
        // Opens Details page when ListTile is tapped
        return DetailsPage(article);
      },
    );
  }
}
