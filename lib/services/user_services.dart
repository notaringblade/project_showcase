import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_showcase/models/user_model.dart';

class UserServices{

  UserModel user = UserModel(username: '', uid: '', posts: []) ;

  Stream fetchUser(uid)async*{
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users').doc(uid).get();

    user = UserModel(username: snap['username'] , uid: snap['uid'], posts: snap['posts']);

  }
}