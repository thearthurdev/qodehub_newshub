import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:qodehub_newshub/logic/news_logic.dart';
import 'package:qodehub_newshub/models/news_article_model.dart';
import 'package:qodehub_newshub/widgets/article_tile.dart';
import 'package:qodehub_newshub/widgets/show_up_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // boolean to track whether the app is trying to reload data
  bool _isRetrying;
  // boolean to track the scroll direction
  bool _isScrollDown;

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _isRetrying = false;
    _isScrollDown = true;

    // Listening to scroll controller to react to scroll events
    _scrollController = ScrollController();
    _scrollController.addListener(handleScrolling);
  }

  // Change the value of _isScrollDown boolean depending on scroll direction
  void handleScrolling() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (_isScrollDown == true) setState(() => _isScrollDown = false);
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_isScrollDown == false) setState(() => _isScrollDown = true);
    }
  }

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
        // Retrieving data using a FutureBuilder in order to handle
        // in-between states
        body: FutureBuilder(
          future: NewsLogic.getNews(),
          builder: (context, snapshot) {
            List<NewsArticle> articles = snapshot.data;

            // Show when data is still being retrieved
            if (articles == null &&
                snapshot.connectionState != ConnectionState.done) {
              return buildLoadingState();
            }

            // Show when there is  an error while retrieving data
            if (!snapshot.hasData || snapshot.hasError) {
              return buildErrorState(snapshot.error);
            }

            // Show when data is empty
            if (articles.length < 1) {
              return buildEmptyState();
            }

            // Show when data is done retrieving successfully and is not empty
            return buildBody(articles);
          },
        ),
      ),
    );
  }

  Widget buildBody(List<NewsArticle> articles) {
    return SafeArea(
      child: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            brightness: Brightness.light,
            expandedHeight: 120.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 16.0, bottom: 8.0),
              title: Text(
                'News',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                return ShowUp(
                  delay: 100 + (10 * i),
                  // Changing the direction the child shows up from based on the user's
                  // scroll direction to simulate an inertia effect
                  direction: _isScrollDown ? ShowUpFrom.bottom : ShowUpFrom.top,
                  child: ArticleTile(articles[i]),
                );
              },
              childCount: articles.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 90.0,
            child: Image.asset('assets/logo.png'),
          ),
          SizedBox(height: 8.0),
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget buildErrorState(var error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.warning,
            color: Color(0xFF11122E),
            size: 56,
          ),
          SizedBox(height: 8.0),
          Text(error),
          SizedBox(height: 8.0),
          buildRetryButton(),
        ],
      ),
    );
  }

  Widget buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 90.0,
            child: Image.asset('assets/logo.png'),
          ),
          SizedBox(height: 8.0),
          Text('No news articles today'),
          SizedBox(height: 16.0),
          buildRetryButton(),
        ],
      ),
    );
  }

  Widget buildRetryButton() {
    // Check if data is reloading and change widget accordingly
    return _isRetrying
        ? CircularProgressIndicator()
        : RaisedButton(
            child: Text(
              'Try Again',
              style: TextStyle().copyWith(color: Colors.white),
            ),
            color: Color(0xFF11122E),
            onPressed: () {
              // Call setState to restart FutureBuilder
              setState(() {
                _isRetrying = true;
              });
            },
          );
  }
}
