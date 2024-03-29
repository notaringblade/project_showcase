import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_showcase/models/post_model.dart';
import 'package:project_showcase/models/user_model.dart';
import 'package:project_showcase/routing/route_constants.dart';
import 'package:project_showcase/services/post_services.dart';
import 'package:project_showcase/services/storage_services.dart';
import 'package:project_showcase/utils/utils.dart';
import 'package:project_showcase/widgets/post_widgets.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Utils utils = Utils();

  Uint8List? image;

  final user = FirebaseAuth.instance.currentUser!;
  void selectImage() async {
    try {
      Uint8List file = await utils.pickImage(ImageSource.gallery);

      String profileUrl =
          await StorageServices().storeImage('profileImage', file);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'profileUrl': profileUrl});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    PostServices postServices = PostServices();
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: Text(
              'User Profile',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          )
        ],
        body: SafeArea(
          child: FutureBuilder<DocumentSnapshot>(
              future: users.doc(user.uid).get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.hasData && !snapshot.data!.exists) {
                  return Text("Document does not exist");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;

                  final thisUser = UserModel(
                      username: data['username'],
                      uid: user.uid,
                      posts: data['posts'],
                      profileUrl: data['profileUrl']);

                  return Column(
                    children: [
                      SizedBox(
                        // height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () => selectImage(),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage:
                                      NetworkImage(data['profileUrl']),
                                ),
                              ),
                            ),
                            Text(
                              "${data['username']}",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              "${user.email}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(RouteConstants.createPost,
                              extra: thisUser);
                        },
                        child: Icon(
                          Icons.add,
                          size: 32,
                        ),
                      ),
                      Divider(
                          color: Theme.of(context).colorScheme.primary,
                          height: 4),
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('posts')
                              .orderBy('createdAt', descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (data['posts'].isEmpty) {
                              return Center(
                                child: Text("No Posts"),
                              );
                            }
                            if (snapshot.hasData) {
                              print(data['posts']);
                              return ListView(
                                shrinkWrap: true,
                                children: snapshot.data!.docs
                                    .where((element) =>
                                        data['posts'].contains(element.id))
                                    .map((doc) {
                                  final post = PostModel(
                                      username: doc['username'],
                                      uid: doc['uid'],
                                      postType: doc['postType'],
                                      postTitle: doc['postTitle'],
                                      postDescription: doc['postDescription'],
                                      thumbnailImageRef:
                                          doc['thumbnailImageRef'],
                                      categories: List.from(doc['categories']),
                                      likes: List.from(doc['likes']),
                                      images: List.from(doc['images']),
                                      createdAt: doc['createdAt']);
                                  return SizedBox(
                                      child: GestureDetector(
                                          onLongPress: () {
                                            setState(() {
                                              postServices.deletePost(
                                                  doc.id, user.uid);
                                            });
                                          },
                                          child: PostWidget(
                                            uid: data['uid'],
                                            post: post,
                                            postId: doc.id,
                                          )));
                                }).toList(),
                              );
                            }
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                      ),
                    ],
                  );
                }

                return Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }
}
