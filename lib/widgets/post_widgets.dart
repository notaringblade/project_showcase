import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:project_showcase/models/post_model.dart';
import 'package:project_showcase/routing/route_constants.dart';
import 'package:project_showcase/services/post_services.dart';
import 'package:project_showcase/widgets/pill_widget.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({
    super.key,
    required this.post,
    required this.postId,
  });

  final PostModel post;
  final String postId;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isLiked = false;
  String url = '';

  @override
  void initState() {
    super.initState();
    getPfp();
    isLiked = widget.post.likes.contains(widget.post.uid);
  }

  Future getPfp() async {
    DocumentSnapshot user = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.post.uid)
        .get();

    try {
      setState(() {
        url = user['profileUrl'];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime time = widget.post.createdAt.toDate();
    String formattedDate = DateFormat("dd-MM-y,  kk:mm").format(time);

    PostServices postServices = PostServices();

    void like() {
      setState(() {
        postServices.likePost(widget.postId, widget.post.uid, isLiked);
        isLiked = !isLiked;
      });
    }

    return GestureDetector(
      onTap: () {
        context.pushNamed(RouteConstants.postScreen,
            extra: widget.post, pathParameters: {'id': widget.postId});
      },
      onDoubleTapDown: (details) {
        like();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 4,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                // width: 400,
                // height: 220,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 60,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(url),
                                  radius: 20,
                                ),
                                Text(
                                  '@${widget.post.username}',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                          Text(formattedDate)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.post.categories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PillWidget(
                                name: widget.post.categories[index],
                                active: false),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      // height: 200,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            widget.post.thumbnailImageRef,

                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return SizedBox(
                                height: 150,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              print(error);
                              return (const Center(
                                child: Text('This Image is Invalid'),
                              ));
                            },
                            // width: double.infinity,
                            // height: double.maxFinite,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    )),
                width: double.infinity,
                // height: 100,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.postTitle,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(onTap: () {
                                    like();
                                  }, child: Builder(builder: (context) {
                                    if (isLiked) {
                                      return const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      );
                                    } else {
                                      return const Icon(
                                          Icons.favorite_border_outlined);
                                    }
                                  })),
                                  Text(widget.post.likes.length.toString())
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [Icon(Icons.comment), Text('0')],
                              ),
                            ),
                            Icon(Icons.share_outlined),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // color: Theme.of(context).colorScheme.secondary,
              )
            ],
          ),
        ),
      ),
    );
  }
}
