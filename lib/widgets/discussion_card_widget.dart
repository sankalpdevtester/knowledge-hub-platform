import 'package:comprehensive_knowledge_hub_platform/lib/models/discussion_model.dart';
import 'package:flutter/material.dart';

class DiscussionCardWidget extends StatelessWidget {
  final DiscussionModel discussion;

  const DiscussionCardWidget({required this.discussion});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              discussion.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(discussion.description),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.comment),
                SizedBox(width: 8),
                Text('${discussion.comments.length} comments'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}