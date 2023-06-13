import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_showcase/models/post_model.dart';
import 'package:project_showcase/services/storage_services.dart';

class PostServices {
  Future createPost(
      String postTitle,
      String postDecription,
      String username,
      String uid,
      List<String> categories,
      Uint8List image,
      List<Uint8List> images,
      BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        },
        barrierDismissible: false);
    await FirebaseFirestore.instance
        .collection('posts')
        .add(PostModel(
                username: username,
                uid: uid,
                postType: 'Software',
                postTitle: postTitle,
                postDescription: postDecription,
                thumbnailImageRef: '',
                categories: categories,
                likes: [],
                images: [],
                createdAt: Timestamp.now())
            .toMap())
        .then((value) async {
      FirebaseFirestore.instance.collection('users').doc(uid).update({
        'posts': FieldValue.arrayUnion([value.id]),
      });

      String thumbnail =
          await StorageServices().postThumbnail('postImages', value.id, image);

      List imageUrls =
          await StorageServices().postImages("postImages", value.id, images);

      FirebaseFirestore.instance.collection('posts').doc(value.id).update({
        'thumbnailImageRef': thumbnail,
        'images': FieldValue.arrayUnion(imageUrls)
      });
    }).catchError((err) => print(err));

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  Future deletePost(id, userId) async {
    await StorageServices().deleteImages('postImages', id);
    await FirebaseFirestore.instance.collection('posts').doc(id).delete();
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'posts': FieldValue.arrayRemove([id])
    });
  }

  bool hasLiked = false;

  Future likePost(postId, uid, liked) async {
    if (liked) {
      await FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      await FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }

  Stream hasLikedCheck(String uid, String postId) async* {
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection('posts').doc(postId).get();

    List likes = (snap.data()! as dynamic)['likes'];

    if (likes.contains(postId)) {
      hasLiked = true;
    } else {
      hasLiked = false;
    }
  }
}
