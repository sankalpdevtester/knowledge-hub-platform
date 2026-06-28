import 'package:comprehensive_knowledge_hub_platform/models/knowledge_model.dart';
import 'package:comprehensive_knowledge_hub_platform/services/knowledge_service.dart';

class KnowledgeSearchUtils {
  static List<KnowledgeModel> searchKnowledge(
    List<KnowledgeModel> knowledgeList,
    String query, {
    String sortBy = 'title',
    bool sortByAscending = true,
    String filterBy = 'all',
  }) {
    List<KnowledgeModel> filteredList = knowledgeList;

    // Filter by category
    if (filterBy != 'all') {
      filteredList = filteredList
          .where((knowledge) => knowledge.category == filterBy)
          .toList();
    }

    // Search by query
    filteredList = filteredList
        .where((knowledge) =>
            knowledge.title.toLowerCase().contains(query.toLowerCase()) ||
            knowledge.description.toLowerCase().contains(query.toLowerCase()))
        .toList();

    // Sort by specified field
    switch (sortBy) {
      case 'title':
        filteredList.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'category':
        filteredList.sort((a, b) => a.category.compareTo(b.category));
        break;
      case 'createdAt':
        filteredList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
    }

    // Reverse sort if necessary
    if (!sortByAscending) {
      filteredList = filteredList.reversed.toList();
    }

    return filteredList;
  }

  static Future<List<KnowledgeModel>> getKnowledgeListFromDatabase(
    KnowledgeService knowledgeService,
  ) async {
    try {
      final knowledgeList = await knowledgeService.getKnowledgeList();
      return knowledgeList;
    } catch (e) {
      print('Error fetching knowledge list: $e');
      return [];
    }
  }

  static List<String> getCategories(List<KnowledgeModel> knowledgeList) {
    final categories = <String>{};
    knowledgeList.forEach((knowledge) => categories.add(knowledge.category));
    return categories.toList();
  }
}