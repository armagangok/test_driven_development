import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:test_driven_development/models/article_model.dart';
import 'package:test_driven_development/pages/news_detail_page.dart';
import 'package:test_driven_development/pages/news_page.dart';
import 'package:test_driven_development/providers/news_provider/news_notifier.dart';
import 'package:test_driven_development/services/news_service.dart';

class MockNewsService extends Mock implements NewsService {}

void main() {
  late final MockNewsService mockNewsService;

  /// Setup methods works like initState,
  /// it runs before all test method. We can initiliaze some code here.
  setUp(() {
    mockNewsService = MockNewsService();
  });

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

  var articlesFromService = [
    ArticleModel(title: "title1", content: "test content1"),
    ArticleModel(title: "title2", content: "test content2"),
    ArticleModel(title: "title3", content: "test content3"),
  ];

  void arrangeNewsServiceReturns3Articles() => when(() => mockNewsService.getArticles()).thenAnswer((_) async => articlesFromService);



  testWidgets(
    "Testing all over the app...",
    (widgetTester) async {
      arrangeNewsServiceReturns3Articles();
      await widgetTester.pumpWidget(buildNewsPage());

      await widgetTester.pump();

      await widgetTester.tap(find.text("test content1"));

      await widgetTester.pumpAndSettle();

      expect(find.byType(NewsPage), findsNothing);
      expect(find.byType(NewsDetailPage), findsOneWidget);

      expect(find.text("title1"), findsOneWidget);
      expect(find.text("test content1"), findsOneWidget);
    },
  );
}
