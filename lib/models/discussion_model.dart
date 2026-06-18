import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class DiscussionModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String categoryId;
  final String userId;
  final List<String> comments;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  const DiscussionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.userId,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DiscussionModel.fromJson(Map<String, dynamic> json) {
    return DiscussionModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      categoryId: json['categoryId'],
      userId: json['userId'],
      comments: List<String>.from(json['comments']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'categoryId': categoryId,
      'userId': userId,
      'comments': comments,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  List<Object> get props => [
        id,
        title,
        description,
        categoryId,
        userId,
        comments,
        createdAt,
        updatedAt,
      ];
}