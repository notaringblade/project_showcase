import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String username;
  final String uid;
  final String postType;
  final String postTitle;
  final String postDescription;
  final String thumbnailImageRef;
  final List<String> images;
  final List<String> likes;
  final List<String> categories;
  final Timestamp createdAt;
  PostModel({
    required this.username,
    required this.uid,
    required this.postType,
    required this.postTitle,
    required this.postDescription,
    required this.thumbnailImageRef,
    required this.likes,
    required this.categories,
    required this.images,
    required this.createdAt,
  });

  PostModel copyWith({
    String? username,
    String? uid,
    String? postType,
    String? postTitle,
    String? postDescription,
    String? thumbnailImageRef,
    List<String>? likes,
    List<String>? categories,
    List<String>? images,
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
      images: images ?? this.images,
      createdAt: createdAt ?? this.createdAt,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'uid': uid,
      'postType': postType,
      'postTitle': postTitle,
      'postDescription': postDescription,
      'thumbnailImageRef': thumbnailImageRef,
      'likes': likes,
      'categories': categories,
      'images': images,
      'createdAt': createdAt,
    };
  }
}
