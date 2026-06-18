import 'package:comprehensive_knowledge_hub_platform/lib/models/discussion_model.dart';
import 'package:comprehensive_knowledge_hub_platform/lib/services/discussion_service.dart';
import 'package:flutter/material.dart';

class DiscussionScreen extends StatefulWidget {
  @override
  _DiscussionScreenState createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  final DiscussionService _discussionService = DiscussionService(DatabaseService());
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discussions'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _discussionService.getDiscussions(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data[index].title),
                        subtitle: Text(snapshot.data[index].description),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _discussionService.createDiscussion(
                          DiscussionModel(
                            id: DateTime.now().millisecondsSinceEpoch.toString(),
                            title: _titleController.text,
                            description: _descriptionController.text,
                            categoryId: 'category1',
                            userId: 'user1',
                            comments: [],
                            createdAt: Timestamp.now(),
                            updatedAt: Timestamp.now(),
                          ),
                        );
                        _formKey.currentState!.reset();
                      }
                    },
                    child: Text('Create Discussion'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}