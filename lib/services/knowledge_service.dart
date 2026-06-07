import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:comprehensive_knowledge_hub_platform/utils/knowledge_cache.dart';
import 'package:comprehensive_knowledge_hub_platform/models/knowledge_model.dart';

class KnowledgeService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final KnowledgeCache _cache = KnowledgeCache();

  Future<List<KnowledgeModel>> getKnowledge() async {
    try {
      final snapshot = await _database.reference().child('knowledge').once();
      if (snapshot.value != null) {
        final knowledgeList = List<KnowledgeModel>.from(
          snapshot.value.map((x) => KnowledgeModel.fromJson(x)).toList(),
        );
        _cache.cacheKnowledge(knowledgeList);
        return knowledgeList;
      } else {
        return _cache.getKnowledge();
      }
    } catch (e) {
      print('Error fetching knowledge: $e');
      return _cache.getKnowledge();
    }
  }

  Future<void> addKnowledge(KnowledgeModel knowledge) async {
    try {
      await _database.reference().child('knowledge').push().set(knowledge.toJson());
      _cache.addKnowledge(knowledge);
    } catch (e) {
      print('Error adding knowledge: $e');
    }
  }

  Future<void> updateKnowledge(KnowledgeModel knowledge) async {
    try {
      await _database.reference().child('knowledge/${knowledge.id}').update(knowledge.toJson());
      _cache.updateKnowledge(knowledge);
    } catch (e) {
      print('Error updating knowledge: $e');
    }
  }

  Future<void> deleteKnowledge(String id) async {
    try {
      await _database.reference().child('knowledge/$id').remove();
      _cache.deleteKnowledge(id);
    } catch (e) {
      print('Error deleting knowledge: $e');
    }
  }

  Future<KnowledgeModel> getKnowledgeById(String id) async {
    try {
      final snapshot = await _database.reference().child('knowledge/$id').once();
      if (snapshot.value != null) {
        return KnowledgeModel.fromJson(snapshot.value);
      } else {
        return _cache.getKnowledgeById(id);
      }
    } catch (e) {
      print('Error fetching knowledge by id: $e');
      return _cache.getKnowledgeById(id);
    }
  }
}