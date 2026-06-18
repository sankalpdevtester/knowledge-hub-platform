import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comprehensive_knowledge_hub_platform/lib/models/discussion_model.dart';
import 'package:comprehensive_knowledge_hub_platform/lib/services/database_service.dart';

class DiscussionService {
  final DatabaseService _databaseService;

  DiscussionService(this._databaseService);

  Future<List<DiscussionModel>> getDiscussions() async {
    final QuerySnapshot querySnapshot = await _databaseService.getDiscussions();
    return querySnapshot.docs
        .map((doc) => DiscussionModel.fromJson(doc.data()))
        .toList();
  }

  Future<DiscussionModel> getDiscussion(String id) async {
    final DocumentSnapshot documentSnapshot = await _databaseService.getDiscussion(id);
    return DiscussionModel.fromJson(documentSnapshot.data());
  }

  Future<void> createDiscussion(DiscussionModel discussion) async {
    await _databaseService.createDiscussion(discussion);
  }

  Future<void> updateDiscussion(DiscussionModel discussion) async {
    await _databaseService.updateDiscussion(discussion);
  }

  Future<void> deleteDiscussion(String id) async {
    await _databaseService.deleteDiscussion(id);
  }

  Future<void> addComment(String discussionId, String comment) async {
    await _databaseService.addComment(discussionId, comment);
  }

  Future<void> removeComment(String discussionId, String comment) async {
    await _databaseService.removeComment(discussionId, comment);
  }
}