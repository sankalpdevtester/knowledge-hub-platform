import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comprehensive_knowledge_hub_platform/lib/models/discussion_model.dart';
import 'package:comprehensive_knowledge_hub_platform/lib/services/database_service.dart';

class DiscussionService {
  final DatabaseService _databaseService;

  DiscussionService(this._databaseService);

  Future<List<DiscussionModel>> getDiscussions() async {
    final QuerySnapshot querySnapshot =
        await _databaseService.firestore.collection('discussions').get();
    return querySnapshot.docs
        .map((doc) => DiscussionModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<DiscussionModel> getDiscussionById(String id) async {
    final DocumentSnapshot documentSnapshot =
        await _databaseService.firestore.collection('discussions').doc(id).get();
    return DiscussionModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
  }

  Future<void> createDiscussion(DiscussionModel discussion) async {
    await _databaseService.firestore
        .collection('discussions')
        .doc(discussion.id)
        .set(discussion.toJson());
  }

  Future<void> updateDiscussion(DiscussionModel discussion) async {
    await _databaseService.firestore
        .collection('discussions')
        .doc(discussion.id)
        .update(discussion.toJson());
  }

  Future<void> deleteDiscussion(String id) async {
    await _databaseService.firestore.collection('discussions').doc(id).delete();
  }
}