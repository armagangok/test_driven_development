import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_driven_development/providers/news_service_provider.dart';
import 'package:test_driven_development/services/news_service.dart';
import 'package:test_driven_development/state/news_state.dart';

part 'news_notifier.g.dart';

@riverpod
class NewsNotifier extends _$NewsNotifier {
  @override
  build() async {
    state = _newsService = ref.read(newsServiceProvider);

    state = NewsLoading();
    await _fetchProducts();

    return state;
  }

  late final NewsService _newsService;

  Future _fetchProducts() async {
    try {
      final data = await _newsService.fetchArticleDataList();
      state = NewsSuccess(newsResponse: data);
    } catch (e) {
      state = NewsFailure(message: 'Error while fetching news');
    }
  }
}
