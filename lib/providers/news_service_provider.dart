import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_driven_development/services/news_service.dart';

final newsServiceProvider = StateProvider<NewsService>((ref) {
  return NewsService();
});
