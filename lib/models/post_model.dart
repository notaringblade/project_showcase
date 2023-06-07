import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String username;
  final String postType;
  final String postTitle;
  final String postDescription;
  final String thumbnailImageRef;
  final List<String> likes;
  final List<String> categories;
  final Timestamp createdAt;
  PostModel({
    required this.username,
    required this.postType,
    required this.postTitle,
    required this.postDescription,
    required this.thumbnailImageRef,
    required this.likes,
    required this.categories,
    required this.createdAt,
  });

  PostModel copyWith({
    String? username,
    String? postType,
    String? postTitle,
    String? postDescription,
    String? thumbnailImageRef,
    List<String>? likes,
    List<String>? categories,
    Timestamp? createdAt,
  }) {
    return PostModel(
      username: username ?? this.username,
      postType: postType ?? this.postType,
      postTitle: postTitle ?? this.postTitle,
      postDescription: postDescription ?? this.postDescription,
      thumbnailImageRef: thumbnailImageRef ?? this.thumbnailImageRef,
      likes: likes ?? this.likes,
      categories: categories ?? this.categories,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'postType': postType,
      'postTitle': postTitle,
      'postDescription': postDescription,
      'thumbnailImageRef': thumbnailImageRef,
      'likes': likes,
      'categories': categories,
      'createdAt': createdAt,
    };
  }
}
