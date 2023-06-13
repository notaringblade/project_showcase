import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_showcase/models/post_model.dart';
import 'package:project_showcase/screens/view_picture_screen.dart';
import 'package:project_showcase/services/post_services.dart';
import 'package:project_showcase/widgets/pill_widget.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key, required this.post, required this.postId})
      : super(key: key);
  final PostModel post;
  final String postId;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool isLiked = false;
  PostServices postServices = PostServices();
  int likes = 0;

  @override
  void initState() {
    super.initState();
    isLiked = widget.post.likes.contains(widget.post.uid);
    likes = widget.post.likes.length;
  }

  @override
  Widget build(BuildContext context) {
    void like() {
      setState(() {
        postServices.likePost(widget.postId, widget.post.uid, isLiked);
        isLiked = !isLiked;
        if (isLiked) {
          likes++;
        } else {
          likes--;
        }
      });
    }

    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
            // floatHeaderSlivers: true,
            physics: NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    title: Text(widget.post.postTitle,
                        style: Theme.of(context).textTheme.titleLarge),
                    backgroundColor: Colors.transparent,
                    // centerTitle: true,
                    elevation: 0,
                    // floating: true,
                    // pinned: true,
                    // snap: true,
                    bottom: Tab(
                        height: 250,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, CupertinoPageRoute(
                              builder: (context) {
                                return ViewPictureScreen(
                                    imageRef: widget.post.thumbnailImageRef);
                              },
                            ));
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: SizedBox(
                              width: double.infinity,
                              // height: 250,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    widget.post.thumbnailImageRef,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                        )),
                  )
                ],
            body: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    Center(
                        child: Text(
                      widget.post.postTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
                    Center(
                      child: Text(
                        '@${widget.post.username}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.post.postDescription,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.post.images.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, CupertinoPageRoute(
                              builder: (context) {
                                return ViewPictureScreen(
                                    imageRef: widget.post.images[index]);
                              },
                            ));
                          },
                          child: SizedBox(
                            height: 300,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  widget.post.images[index],

                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return SizedBox(
                                      height: 200,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
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
                          ),
                        );
                      },
                    )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              GestureDetector(onTap: () {
                                like();
                              }, child: Builder(builder: (context) {
                                if (isLiked) {
                                  return const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 32,
                                  );
                                } else {
                                  return Icon(
                                    Icons.favorite_border_outlined,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  );
                                }
                              })),
                              Text(
                                likes.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.comment_outlined,
                                color: Theme.of(context).colorScheme.primary,
                                size: 32,
                              ),
                              Text(
                                '0',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              )
                            ],
                          ),
                          Icon(
                            Icons.share_outlined,
                            color: Theme.of(context).colorScheme.primary,
                            size: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
