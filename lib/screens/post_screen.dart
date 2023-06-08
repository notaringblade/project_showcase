import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_showcase/models/post_model.dart';
import 'package:project_showcase/screens/view_picture_screen.dart';
import 'package:project_showcase/widgets/pill_widget.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key, required this.post}) : super(key: key);
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          // floatHeaderSlivers: true,
          physics: NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  title: Text(post.postTitle,
                      style: Theme.of(context).textTheme.titleLarge),
                  backgroundColor: Colors.transparent,
                  // centerTitle: true,
                  elevation: 0,
                  // floating: true,
                  // pinned: true,
                  // snap: true,
                  bottom: Tab(
                      height: 250,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          width: double.infinity,
                          // height: 250,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                post.thumbnailImageRef,
                                fit: BoxFit.cover,
                              )),
                        ),
                      )),
                )
              ],
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text(
                  post.postTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                )),
                Center(
                  child: Text(
                    '@${post.username}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: post.categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PillWidget(name: post.categories[index]),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    post.postDescription,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, CupertinoPageRoute(
                          builder: (context) {
                            return ViewPictureScreen(
                                imageRef: post.thumbnailImageRef);
                          },
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            post.thumbnailImageRef,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ))
              ],
            ),
          )),
    );
  }
}
