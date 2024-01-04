import 'package:test_driven_development/models/article_model.dart';

abstract class ArticleState {}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleFailure extends ArticleState {
  ArticleFailure({
    required this.message,
  });
  final String message;
}

class ArticleSuccess extends ArticleState {
  ArticleSuccess({
    required this.articleListData,
  });

  final List<ArticleModel>? articleListData;
}
