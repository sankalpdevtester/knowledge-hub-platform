import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:knowledge_hub/utils/knowledge_cache.dart';

// Define a class to represent a knowledge article
class KnowledgeArticle {
  String id;
  String title;
  String content;
  String authorId;
  String authorName;
  DateTime createdAt;
  DateTime updatedAt;

  KnowledgeArticle({
    required this.id,
    required this.title,
    required this.content,
    required this.authorId,
    required this.authorName,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert a Firestore document to a KnowledgeArticle object
  factory KnowledgeArticle.fromDocument(DocumentSnapshot document) {
    return KnowledgeArticle(
      id: document.id,
      title: document['title'],
      content: document['content'],
      authorId: document['authorId'],
      authorName: document['authorName'],
      createdAt: document['createdAt'].toDate(),
      updatedAt: document['updatedAt'].toDate(),
    );
  }

  // Convert a KnowledgeArticle object to a Firestore document
  Map<String, dynamic> toDocument() {
    return {
      'title': title,
      'content': content,
      'authorId': authorId,
      'authorName': authorName,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}

// Define a class to represent a discussion forum post
class DiscussionPost {
  String id;
  String content;
  String authorId;
  String authorName;
  DateTime createdAt;
  DateTime updatedAt;

  DiscussionPost({
    required this.id,
    required this.content,
    required this.authorId,
    required this.authorName,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert a Firestore document to a DiscussionPost object
  factory DiscussionPost.fromDocument(DocumentSnapshot document) {
    return DiscussionPost(
      id: document.id,
      content: document['content'],
      authorId: document['authorId'],
      authorName: document['authorName'],
      createdAt: document['createdAt'].toDate(),
      updatedAt: document['updatedAt'].toDate(),
    );
  }

  // Convert a DiscussionPost object to a Firestore document
  Map<String, dynamic> toDocument() {
    return {
      'content': content,
      'authorId': authorId,
      'authorName': authorName,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}

// Define a class to manage the core data layer
class KnowledgeDataLayer {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get a list of all knowledge articles
  Future<List<KnowledgeArticle>> getKnowledgeArticles() async {
    final QuerySnapshot snapshot = await _firestore.collection('knowledgeArticles').get();
    return snapshot.docs.map((document) => KnowledgeArticle.fromDocument(document)).toList();
  }

  // Get a knowledge article by ID
  Future<KnowledgeArticle> getKnowledgeArticleById(String id) async {
    final DocumentSnapshot document = await _firestore.collection('knowledgeArticles').doc(id).get();
    return KnowledgeArticle.fromDocument(document);
  }

  // Create a new knowledge article
  Future<void> createKnowledgeArticle(KnowledgeArticle article) async {
    final DocumentReference document = await _firestore.collection('knowledgeArticles').add(article.toDocument());
    article.id = document.id;
    await _firestore.collection('knowledgeArticles').doc(document.id).update({'id': document.id});
  }

  // Update a knowledge article
  Future<void> updateKnowledgeArticle(KnowledgeArticle article) async {
    await _firestore.collection('knowledgeArticles').doc(article.id).update(article.toDocument());
  }

  // Delete a knowledge article
  Future<void> deleteKnowledgeArticle(String id) async {
    await _firestore.collection('knowledgeArticles').doc(id).delete();
  }

  // Get a list of all discussion posts
  Future<List<DiscussionPost>> getDiscussionPosts() async {
    final QuerySnapshot snapshot = await _firestore.collection('discussionPosts').get();
    return snapshot.docs.map((document) => DiscussionPost.fromDocument(document)).toList();
  }

  // Get a discussion post by ID
  Future<DiscussionPost> getDiscussionPostById(String id) async {
    final DocumentSnapshot document = await _firestore.collection('discussionPosts').doc(id).get();
    return DiscussionPost.fromDocument(document);
  }

  // Create a new discussion post
  Future<void> createDiscussionPost(DiscussionPost post) async {
    final DocumentReference document = await _firestore.collection('discussionPosts').add(post.toDocument());
    post.id = document.id;
    await _firestore.collection('discussionPosts').doc(document.id).update({'id': document.id});
  }

  // Update a discussion post
  Future<void> updateDiscussionPost(DiscussionPost post) async {
    await _firestore.collection('discussionPosts').doc(post.id).update(post.toDocument());
  }

  // Delete a discussion post
  Future<void> deleteDiscussionPost(String id) async {
    await _firestore.collection('discussionPosts').doc(id).delete();
  }
}