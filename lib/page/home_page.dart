import 'package:flutter/material.dart';
import 'package:project_showcase/models/post_model.dart';
import 'package:project_showcase/widgets/pill_widget.dart';
import 'package:project_showcase/widgets/post_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'Mobile',
      'Web',
      'Product',
      'Community',
      'Announcement'
    ];

    List<PostModel> posts = [
      PostModel(
        postTitle: "Post 1",
        username: 'notaringblade',
        postType: 'Software',
        postDescription: 'Post 1 description',
        thumbnailImageRef:
            'https://cdn.dribbble.com/userupload/3284122/file/original-7648ab335ef534aa085dc038ce4d5d78.png?resize=400x0',
        categories: ['Mobile', 'UX', "UI"],
        createdAt: DateTime.now(),
      ),
      PostModel(
        postTitle: "Post 2",
        username: 'gawd',
        postType: 'Software',
        postDescription: 'Post 2 description',
        thumbnailImageRef:
            'https://img.freepik.com/free-vector/various-screens-violet-public-transport-mobile-app_23-2148704862.jpg',
        categories: ['Mobile', 'UX'],
        createdAt: DateTime.now(),
      )
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
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return PostWidget(post: posts[index]);
              },
            ),
          ),
          // PostWidget(imageRef: ''),
        ],
      ),
    );
  }
}
