import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qodehub_newshub/models/news_article_model.dart';

class NewsLogic {
  static String _dataURL =
      'https://learnappmaking.com/ex/news/articles/Apple?secret=CHWGk3OTwgObtQxGqdLvVhwji6FsYm95oe87o3ju';

  static Future<List<NewsArticle>> getNews() async {
    // Creating an empty list to be populated when data is retrieved online
    List<NewsArticle> newsArticles = [];

    // Using the try-catch block to handle any errors which may occur
    try {
      //Getting data in JSON format and decoding it for use in the app
      http.Response response = await http.get(_dataURL);
      var data = jsonDecode(response.body);

      int articleCount = data['count'];

      for (int i = 0; i < articleCount; i++) {
        var article = data['articles'][i];

        // List of articles will be populated here
        newsArticles.add(
          NewsArticle(
            id: article['id'],
            url: article['url'],
            title: article['title'],
            text: article['text'],
            publisher: article['publisher'],
            author: article['author'],
            image: article['image'],
            date: article['date'],
          ),
        );
      }
    } catch (e) {
      // Print out what error occurred while trying to get the data
      print(e);
    }

    return newsArticles;
  }
}
