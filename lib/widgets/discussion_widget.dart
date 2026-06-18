import 'package:flutter/material.dart';
import 'package:comprehensive_knowledge_hub_platform/lib/models/discussion_model.dart';
import 'package:comprehensive_knowledge_hub_platform/lib/services/discussion_service.dart';

class DiscussionWidget extends StatefulWidget {
  final DiscussionModel discussion;

  DiscussionWidget({@required this.discussion});

  @override
  _DiscussionWidgetState createState() => _DiscussionWidgetState();
}

class _DiscussionWidgetState extends State<DiscussionWidget> {
  final DiscussionService _discussionService = DiscussionService(DatabaseService());
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.discussion.title),
        Text(widget.discussion.description),
        SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.discussion.comments.length,
          itemBuilder: (context, index) {
            return Text(widget.discussion.comments[index]);
          },
        ),
        SizedBox(height: 20),
        TextField(
          controller: _commentController,
          decoration: InputDecoration(
            labelText: 'Add a comment',
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            _discussionService.addComment(widget.discussion.id, _commentController.text);
            _commentController.clear();
          },
          child: Text('Post'),
        ),
      ],
    );
  }
}