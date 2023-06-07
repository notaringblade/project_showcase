import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_showcase/models/post_model.dart';

class PostServices {
  Future createPost(String postTitle, String postDecription, String username,
      String uid) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .add(PostModel(
                username: username,
                postType: 'Software',
                postTitle: postTitle,
                postDescription: postDecription,
                thumbnailImageRef:
                    'https://cdn.dribbble.com/userupload/3284122/file/original-7648ab335ef534aa085dc038ce4d5d78.png?resize=400x0',
                categories: ['UI'],
                likes: [],
                createdAt: Timestamp.now())
            .toMap())
        .then((value) =>
            FirebaseFirestore.instance.collection('users').doc(uid).update({
              'posts': FieldValue.arrayUnion([value.id])
            }))
        .catchError((err) => print(err));
  }
}
