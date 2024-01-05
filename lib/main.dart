import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_driven_development/providers/news_provider/news_notifier.dart';
import 'package:test_driven_development/services/news_service.dart';

import 'pages/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewsChangeNotifier(NewsService()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
