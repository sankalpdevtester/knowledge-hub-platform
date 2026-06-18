import 'package:comprehensive_knowledge_hub_platform/lib/models/discussion_model.dart';
import 'package:comprehensive_knowledge_hub_platform/lib/services/discussion_service.dart';
import 'package:flutter/material.dart';

class DiscussionDetailScreen extends StatefulWidget {
  final String discussionId;

  const DiscussionDetailScreen({required this.discussionId});

  @override
  _DiscussionDetailScreenState createState() => _DiscussionDetailScreenState();
}

class _DiscussionDetailScreenState extends State<DiscussionDetailScreen> {
  final DiscussionService _discussionService = DiscussionService(DatabaseService());
  final _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discussion Detail'),
      ),
      body: FutureBuilder(
        future: _discussionService.getDiscussionById(widget.discussionId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                DiscussionCardWidget(discussion: snapshot.data),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.comments.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data.comments[index]),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          decoration: InputDecoration(
                            labelText: 'Comment',
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Add comment to discussion
                        },
                        child: Text('Comment'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}