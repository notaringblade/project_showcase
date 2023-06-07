// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final String username;
  final String uid;
  final List posts;

  UserModel({
    required this.username,
    required this.uid,
    required this.posts,
  });

  UserModel copyWith({
    String? username,
    String? uid,
    List? posts,
  }) {
    return UserModel(
      username: username ?? this.username,
      uid: uid ?? this.uid,
      posts: posts ?? this.posts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'uid': uid,
      'posts': posts,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        username: map['username'] as String,
        uid: map['uid'] as String,
        posts: List.from(
          (map['posts'] as List),
        ));
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserModel(username: $username, uid: $uid, posts: $posts)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.uid == uid &&
        listEquals(other.posts, posts);
  }

  @override
  int get hashCode => username.hashCode ^ uid.hashCode ^ posts.hashCode;
}
