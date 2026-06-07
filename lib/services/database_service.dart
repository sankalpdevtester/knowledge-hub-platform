import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:knowledge_hub_platform/models/knowledge_model.dart';
import 'package:knowledge_hub_platform/services/knowledge_service.dart';
import 'package:knowledge_hub_platform/utils/knowledge_cache.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createKnowledge(KnowledgeModel knowledge) async {
    await _firestore.collection('knowledge').add({
      'title': knowledge.title,
      'content': knowledge.content,
      'author': _auth.currentUser?.uid,
      'createdAt': Timestamp.now(),
    });
  }

  Future<List<KnowledgeModel>> getKnowledge() async {
    QuerySnapshot snapshot = await _firestore.collection('knowledge').get();
    List<KnowledgeModel> knowledgeList = [];
    snapshot.docs.forEach((doc) {
      KnowledgeModel knowledge = KnowledgeModel(
        id: doc.id,
        title: doc['title'],
        content: doc['content'],
        author: doc['author'],
        createdAt: doc['createdAt'],
      );
      knowledgeList.add(knowledge);
    });
    return knowledgeList;
  }

  Future<void> updateKnowledge(KnowledgeModel knowledge) async {
    await _firestore.collection('knowledge').doc(knowledge.id).update({
      'title': knowledge.title,
      'content': knowledge.content,
    });
  }

  Future<void> deleteKnowledge(String id) async {
    await _firestore.collection('knowledge').doc(id).delete();
  }

  Future<void> cacheKnowledge(KnowledgeModel knowledge) async {
    KnowledgeCache cache = KnowledgeCache();
    await cache.cacheKnowledge(knowledge);
  }

  Future<KnowledgeModel> getKnowledgeFromCache(String id) async {
    KnowledgeCache cache = KnowledgeCache();
    return await cache.getKnowledgeFromCache(id);
  }

  Future<void> clearCache() async {
    KnowledgeCache cache = KnowledgeCache();
    await cache.clearCache();
  }

  Stream<List<KnowledgeModel>> getKnowledgeStream() {
    return _firestore.collection('knowledge').snapshots().map((snapshot) {
      List<KnowledgeModel> knowledgeList = [];
      snapshot.docs.forEach((doc) {
        KnowledgeModel knowledge = KnowledgeModel(
          id: doc.id,
          title: doc['title'],
          content: doc['content'],
          author: doc['author'],
          createdAt: doc['createdAt'],
        );
        knowledgeList.add(knowledge);
      });
      return knowledgeList;
    });
  }
}