import 'package:comprehensive_knowledge_hub_platform/models/knowledge_model.dart';
import 'package:comprehensive_knowledge_hub_platform/services/knowledge_service.dart';

class KnowledgeSearchUtils {
  static Future<List<KnowledgeModel>> searchKnowledge(
      String query, String category, String sortBy) async {
    final knowledgeService = KnowledgeService();
    final knowledgeList = await knowledgeService.getKnowledgeList();

    final filteredKnowledgeList = knowledgeList
        .where((knowledge) =>
            knowledge.title.toLowerCase().contains(query.toLowerCase()) ||
            knowledge.description.toLowerCase().contains(query.toLowerCase()) ||
            knowledge.category.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (category.isNotEmpty) {
      filteredKnowledgeList.removeWhere((knowledge) =>
          knowledge.category.toLowerCase() != category.toLowerCase());
    }

    if (sortBy.isNotEmpty) {
      switch (sortBy) {
        case 'title':
          filteredKnowledgeList.sort((a, b) => a.title.compareTo(b.title));
          break;
        case 'category':
          filteredKnowledgeList.sort((a, b) => a.category.compareTo(b.category));
          break;
        case 'date':
          filteredKnowledgeList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
          break;
      }
    }

    return filteredKnowledgeList;
  }

  static List<String> getCategories(List<KnowledgeModel> knowledgeList) {
    final categories = <String>[];
    knowledgeList.forEach((knowledge) {
      if (!categories.contains(knowledge.category)) {
        categories.add(knowledge.category);
      }
    });
    return categories;
  }

  static List<String> getSortOptions() {
    return ['title', 'category', 'date'];
  }
}

class KnowledgeSearchFilter {
  String query;
  String category;
  String sortBy;

  KnowledgeSearchFilter({this.query = '', this.category = '', this.sortBy = ''});
}