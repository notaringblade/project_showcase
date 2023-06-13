import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_showcase/models/post_model.dart';
import 'package:project_showcase/services/auth_service.dart';
import 'package:project_showcase/widgets/post_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> selectedCategories = ['','mobile', 'ui'];
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    Auth auth = Auth();

    List<String> categories = [
      'mobile',
      'web',
      'product',
      'community',
      'announcement',
      'ui'
    ];

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        physics: NeverScrollableScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    auth.signOut();
                  },
                  child: Icon(
                    Icons.logout_outlined,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              )
            ],
            title:
                Text("PROJECT", style: Theme.of(context).textTheme.titleLarge),
            backgroundColor: Colors.transparent,
            // centerTitle: true,
            elevation: 0,
            floating: true,
          )
        ],
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .where('categories',
                            arrayContainsAny: categories)
                        .orderBy('createdAt', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("Error"),
                        );
                      } else if (snapshot.hasData) {
                        return SafeArea(
                          child: ListView(
                            children: snapshot.data!.docs
                                .where((element) =>
                                    !data['posts'].contains(element.id))
                                .map((doc) {
                              final post = PostModel(
                                  username: doc['username'],
                                  uid: doc['uid'],
                                  postType: doc['postType'],
                                  postTitle: doc['postTitle'],
                                  postDescription: doc['postDescription'],
                                  thumbnailImageRef: doc['thumbnailImageRef'],
                                  categories: List.from(doc['categories']),
                                  likes: List.from(doc['likes']),
                                  images: List.from(doc['images']),
                                  createdAt: doc['createdAt']);
                              return SizedBox(
                                  child: PostWidget(
                                post: post,
                                postId: doc.id,
                              ));
                            }).toList(),
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    });
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error"),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}


