import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_showcase/models/post_model.dart';
import 'package:project_showcase/models/user_model.dart';
import 'package:project_showcase/screens/create_post.dart';
import 'package:project_showcase/services/post_services.dart';
import 'package:project_showcase/widgets/post_widgets.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    PostServices postServices = PostServices();
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: Text('Project', style: Theme.of(context).textTheme.titleLarge,),
            elevation: 0,
            backgroundColor: Colors.transparent,
          )
        ],
        body: FutureBuilder<DocumentSnapshot>(
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
                    posts: data['posts']);

                return Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        // height: 120,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.person_outline,
                              size: 60,
                            ),
                            Text(
                              "${data['username']}",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              "${user.email}",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {});
                        Navigator.push(context, CupertinoPageRoute(
                          builder: (context) {
                            return CreatePost(
                              user: thisUser,
                            );
                          },
                        ));
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
                                    postType: doc['postType'],
                                    postTitle: doc['postTitle'],
                                    postDescription: doc['postDescription'],
                                    thumbnailImageRef: doc['thumbnailImageRef'],
                                    categories: List.from(doc['categories']),
                                    likes: List.from(doc['likes']),
                                    createdAt: doc['createdAt']);
                                return SizedBox(
                                    child: GestureDetector(
                                        onLongPress: () {
                                          setState(() {
                                            postServices.deletePost(doc.id, user.uid);
                                          });
                                        },
                                        child: PostWidget(
                                          post: post,
                                          userid: user.uid,
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
    );
  }
}
