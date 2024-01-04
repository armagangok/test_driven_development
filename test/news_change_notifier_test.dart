import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_driven_development/models/article_model.dart';
import 'package:test_driven_development/providers/news_provider/news_notifier.dart';
import 'package:test_driven_development/providers/news_provider/news_state.dart';
import 'package:test_driven_development/services/news_service.dart';

class BadMockNewsService implements NewsService {
  @override
  Future<List<ArticleModel>> fetchArticleDataList() async {
    return [
      ArticleModel(title: 'Test Title 1', content: 'c ontentcontent con tent conte ntcont ent'),
      ArticleModel(title: 'Test Title 1', content: 'cont entc ontent content cont entcon tent'),
      ArticleModel(title: 'Test Title 1', content: 'cont entc  ontent content conte ntcontent'),
    ];
  }
}

class MockNewsService extends Mock implements NewsService {}

void main() {
  late NewsChangeNotifier newsChangeNotifier;
  late MockNewsService mockNewsService;

  /// Setup methods works like initState,
  /// it runs before all test method. We can initiliaze some code here.
  setUp(() {
    mockNewsService = MockNewsService();
    newsChangeNotifier = NewsChangeNotifier(mockNewsService);
  });

  test(
    "İnitial values are correct.",
    () {
      final state = newsChangeNotifier.articleState;
      if (state is ArticleInitial) {
      } else if (state is ArticleLoading) {
      } else if (state is ArticleSuccess) {
        expect(state.articleListData, []);
      } else if (state is ArticleFailure) {
      } else {
        "";
        throw "Unknown State For Article";
      }
    },
  );
}
