import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:test_driven_development/models/article_model.dart';

////////////////////////////////////////////////
////////////////////////////////////////////////
////////////////////////////////////////////////
/// This service simulates a remote data service.

class NewsService {
  final _articles = List.generate(
    20,
    (index) => ArticleModel(
      title: lorem(paragraphs: 1, words: 3),
      content: lorem(paragraphs: 5, words: 100),
    ),
  );

  Future<List<ArticleModel>> getArticles() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    return _articles;
  }
}
