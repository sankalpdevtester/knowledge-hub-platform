import 'package:flutter/material.dart';
import 'package:comprehensive_knowledge_hub_platform/lib/models/knowledge_model.dart';
import 'package:comprehensive_knowledge_hub_platform/lib/services/article_service.dart';
import 'package:comprehensive_knowledge_hub_platform/lib/widgets/article_editor_widget.dart';

class ArticleScreen extends StatefulWidget {
  final KnowledgeModel? knowledgeModel;

  const ArticleScreen({Key? key, this.knowledgeModel}) : super(key: key);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  final ArticleService _articleService = ArticleService(DatabaseService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              widget.knowledgeModel?.title ?? '',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            Text(
              widget.knowledgeModel?.content ?? '',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticleEditorWidget(knowledgeModel: widget.knowledgeModel),
                  ),
                );
                setState(() {});
              },
              child: const Text('Edit Article'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await _articleService.deleteArticle(widget.knowledgeModel!.id);
                Navigator.pop(context);
              },
              child: const Text('Delete Article'),
            ),
          ],
        ),
      ),
    );
  }
}