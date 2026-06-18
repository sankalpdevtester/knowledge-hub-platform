import 'package:flutter/material.dart';
import 'package:comprehensive_knowledge_hub_platform/lib/models/discussion_model.dart';
import 'package:comprehensive_knowledge_hub_platform/lib/services/discussion_service.dart';
import 'package:comprehensive_knowledge_hub_platform/lib/widgets/discussion_widget.dart';

class DiscussionScreen extends StatefulWidget {
  final String discussionId;

  DiscussionScreen({@required this.discussionId});

  @override
  _DiscussionScreenState createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  final DiscussionService _discussionService = DiscussionService(DatabaseService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discussion'),
      ),
      body: FutureBuilder(
        future: _discussionService.getDiscussion(widget.discussionId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final DiscussionModel discussion = snapshot.data;
            return DiscussionWidget(discussion: discussion);
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