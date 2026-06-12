import 'package:flutter/material.dart';
import 'package:comprehensive_knowledge_hub_platform/lib/models/knowledge_model.dart';
import 'package:comprehensive_knowledge_hub_platform/lib/services/knowledge_service.dart';
import 'package:comprehensive_knowledge_hub_platform/lib/utils/auth_utils.dart';

class ArticleEditorWidget extends StatefulWidget {
  final KnowledgeModel? knowledgeModel;

  const ArticleEditorWidget({Key? key, this.knowledgeModel}) : super(key: key);

  @override
  _ArticleEditorWidgetState createState() => _ArticleEditorWidgetState();
}

class _ArticleEditorWidgetState extends State<ArticleEditorWidget> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.knowledgeModel != null) {
      _titleController.text = widget.knowledgeModel!.title;
      _contentController.text = widget.knowledgeModel!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Editor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                maxLines: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some content';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final knowledgeModel = KnowledgeModel(
                      title: _titleController.text,
                      content: _contentController.text,
                      authorId: await AuthUtils.getUserId(),
                    );
                    if (widget.knowledgeModel != null) {
                      knowledgeModel.id = widget.knowledgeModel!.id;
                    }
                    await KnowledgeService.saveKnowledge(knowledgeModel);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save Article'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}