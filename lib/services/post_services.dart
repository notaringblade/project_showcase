import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_showcase/models/post_model.dart';

class PostServices {
  Future createPost(String postTitle, String postDecription, String username,
      String uid, String imageLink, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );
    await FirebaseFirestore.instance
        .collection('posts')
        .add(PostModel(
                username: username,
                postType: 'Software',
                postTitle: postTitle,
                postDescription: postDecription,
                thumbnailImageRef: imageLink,
                categories: ['UI'],
                likes: [],
                createdAt: Timestamp.now())
            .toMap())
        .then((value) =>
            FirebaseFirestore.instance.collection('users').doc(uid).update({
              'posts': FieldValue.arrayUnion([value.id])
            }))
        .catchError((err) => print(err));

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  Future deletePost(id, userId) async {

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
