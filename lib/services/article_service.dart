import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comprehensive_knowledge_hub_platform/lib/models/knowledge_model.dart';
import 'package:comprehensive_knowledge_hub_platform/lib/services/database_service.dart';

class ArticleService {
  final DatabaseService _databaseService;

  ArticleService(this._databaseService);

  Future<List<KnowledgeModel>> getArticles() async {
    final querySnapshot = await _databaseService.getKnowledgeCollection().get();
    return querySnapshot.docs
        .map((doc) => KnowledgeModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<KnowledgeModel> getArticle(String id) async {
    final docSnapshot = await _databaseService.getKnowledgeCollection().doc(id).get();
    return KnowledgeModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
  }

  Future<void> saveArticle(KnowledgeModel knowledgeModel) async {
    if (knowledgeModel.id != null) {
      await _databaseService.getKnowledgeCollection().doc(knowledgeModel.id).set(knowledgeModel.toJson());
    } else {
      final docRef = await _databaseService.getKnowledgeCollection().add(knowledgeModel.toJson());
      knowledgeModel.id = docRef.id;
    }
  }

  Future<void> deleteArticle(String id) async {
    await _databaseService.getKnowledgeCollection().doc(id).delete();
  }
}