import 'package:flutter/material.dart';
import 'package:comprehensive_knowledge_hub_platform/lib/models/knowledge_model.dart';
import 'package:comprehensive_knowledge_hub_platform/lib/services/article_service.dart';
import 'package:comprehensive_knowledge_hub_platform/lib/screens/article_screen.dart';

class ArticleListScreen extends StatefulWidget {
  @override
  _ArticleListScreenState createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  final ArticleService _articleService = ArticleService(DatabaseService());
  List<KnowledgeModel> _articles = [];

  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  Future<void> _loadArticles() async {
    final articles = await _articleService.getArticles();
    setState(() {
      _articles = articles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _articles.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_articles[index].title),
              subtitle: Text(_articles[index].content),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticleScreen(knowledgeModel: _articles[index]),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleEditorWidget(),
            ),
          );
          _loadArticles();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}