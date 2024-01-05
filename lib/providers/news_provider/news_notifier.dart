import 'package:flutter/material.dart';
import 'package:test_driven_development/models/article_model.dart';
import 'package:test_driven_development/services/news_service.dart';

class NewsChangeNotifier extends ChangeNotifier {
  NewsChangeNotifier(this._newsService);

  final NewsService _newsService;

  List<ArticleModel> _articles = [];
  List<ArticleModel> get articles => _articles;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getArticles() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await _newsService.getArticles();

      _articles = data;
      notifyListeners();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
