import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_driven_development/models/article_model.dart';
import 'package:test_driven_development/providers/news_provider/news_notifier.dart';
import 'package:test_driven_development/services/news_service.dart';

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
      expect(newsChangeNotifier.articles, []);
      expect(newsChangeNotifier.isLoading, false);
    },
  );

  group("Get articles.", () {
    var articlesFromService = [
      ArticleModel(title: "title1", content: "test content1"),
      ArticleModel(title: "title2", content: "test content2"),
      ArticleModel(title: "title3", content: "test content3"),
    ];
    
    void arrangeNewsServiceReturns3Articles() {
      when(() => mockNewsService.getArticles()).thenAnswer((_) async => articlesFromService);
    }

    test("Get articles using NewsService.", () async {
      when(() => mockNewsService.getArticles()).thenAnswer((invocation) async => []);
      await newsChangeNotifier.getArticles();
      verify(() => mockNewsService.getArticles()).called(1);
    });

    test(
      "Indicates loading of data, sets articles to the ones from the service.",
      () async {
        arrangeNewsServiceReturns3Articles();
        final future = newsChangeNotifier.getArticles();
        expect(newsChangeNotifier.isLoading, true);
        await future;
        expect(newsChangeNotifier.articles, articlesFromService);
        expect(newsChangeNotifier.isLoading, false);
      },
    );
  });
}
