import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_driven_development/pages/news_detail_page.dart';
import 'package:test_driven_development/providers/news_provider/news_notifier.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late final NewsChangeNotifier newsProvider;
  @override
  void initState() {
    newsProvider = context.read<NewsChangeNotifier>();

    Future.microtask(() => newsProvider.getArticles());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Articles"),
      ),
      body: Consumer<NewsChangeNotifier>(
        builder: (context, provider, widget) {
          return provider.isLoading
              ? const Center(child: CircularProgressIndicator.adaptive())
              : ListView.builder(
                  itemCount: provider.articles.length,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NewsDetailPage(article: provider.articles[index])),
                        );
                      },
                      title: Text(provider.articles[index].title),
                      subtitle: Text(
                        provider.articles[index].content,
                        maxLines: 2,
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
