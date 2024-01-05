import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:test_driven_development/models/article_model.dart';
import 'package:test_driven_development/pages/news_page.dart';
import 'package:test_driven_development/providers/news_provider/news_notifier.dart';
import 'package:test_driven_development/services/news_service.dart';

class MockNewsService extends Mock implements NewsService {}

void main() {
  late MockNewsService mockNewsService;

  /// Setup methods works like initState,
  /// it runs before all test method. We can initiliaze some code here.
  setUp(() {
    mockNewsService = MockNewsService();
  });

  var articlesFromService = [
    ArticleModel(title: "title1", content: "test content1"),
    ArticleModel(title: "title2", content: "test content2"),
    ArticleModel(title: "title3", content: "test content3"),
  ];

  void arrangeNewsServiceReturns3Articles() {
    when(() => mockNewsService.getArticles()).thenAnswer((_) async => articlesFromService);
  }

  void arrangeNewsServiceReturns3ArticlesAfter2Seconds() {
    when(() => mockNewsService.getArticles()).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 2));
      return articlesFromService;
    });
  }

  Widget buildNewsPage() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewsChangeNotifier(mockNewsService),
        ),
      ],
      child: const MaterialApp(
        home: NewsPage(),
      ),
    );
  }

  testWidgets(
    "Title is displayed.",
    (WidgetTester tester) async {
      arrangeNewsServiceReturns3Articles();
      await tester.pumpWidget(buildNewsPage());
      expect(find.text("Articles"), findsOneWidget);
    },
  );

  testWidgets(
    "Loading indicator is displayed while waiting for articles.",
    (WidgetTester tester) async {
      arrangeNewsServiceReturns3ArticlesAfter2Seconds();
      await tester.pumpWidget(buildNewsPage());
      await tester.pump(Durations.long2);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();
    },
  );

  testWidgets(
    "Articles are displayed.",
    (WidgetTester tester) async {
      arrangeNewsServiceReturns3ArticlesAfter2Seconds();

      await tester.pumpWidget(buildNewsPage());

      await tester.pump();

      for (final article in articlesFromService) {
        expect(article.title.isNotEmpty, true);
        expect(article.content.isNotEmpty, true);
      }

      await tester.pumpAndSettle();
    },
  );
}
