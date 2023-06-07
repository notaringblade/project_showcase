import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_showcase/models/post_model.dart';
import 'package:project_showcase/widgets/pill_widget.dart';
import 'package:project_showcase/widgets/post_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    List<String> categories = [
      'Mobile',
      'Web',
      'Product',
      'Community',
      'Announcement',
      'UI'
    ];

    

    return Scaffold(
      body: Column(
        children: [
          Center(
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PillWidget(name: categories[index]),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.uid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('posts')
                            .where('categories', arrayContainsAny: categories)
                            // .orderBy('createdAt', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error"),
                            );
                          } else if (snapshot.hasData) {
                            return ListView(
                              children: snapshot.data!.docs
                                  .where((element) =>
                                      !data['posts'].contains(element.id))
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
                                return SizedBox(child: PostWidget(post: post));
                              }).toList(),
                            );
                          }
                          return Center(
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
          // PostWidget(imageRef: ''),
        ],
      ),
    );
  }
}