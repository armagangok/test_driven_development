import 'package:test_driven_development/models/article_model.dart';

abstract class NewsState {}

class NewsLoading extends NewsState {}

class NewsFailure extends NewsState {
  NewsFailure({required this.message});
  final String message;
}

class NewsSuccess extends NewsState {
  NewsSuccess({required this.newsResponse});

  final List<ArticleModel> newsResponse;
}
