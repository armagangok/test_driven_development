import 'package:flutter/material.dart';
import 'package:test_driven_development/providers/news_provider/news_state.dart';
import 'package:test_driven_development/services/news_service.dart';

class NewsChangeNotifier extends ChangeNotifier {
  NewsChangeNotifier(this._newsService);

  late final NewsService _newsService;

  ArticleState articleState = ArticleInitial();

  Future _fetchProducts() async {
    articleState = ArticleLoading();
    notifyListeners();

    try {
      final data = await _newsService.fetchArticleDataList();

      articleState = ArticleSuccess(articleListData: data);
      notifyListeners();
    } catch (e) {
      articleState = ArticleFailure(message: 'Error while fetching news');
      notifyListeners();
    }
  }
}
