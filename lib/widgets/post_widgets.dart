import 'package:flutter/material.dart';
import 'package:project_showcase/models/post_model.dart';
import 'package:project_showcase/widgets/pill_widget.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Theme.of(context).colorScheme.primary)),
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
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.person_outline),
                            Text(post.username),
                          ],
                        ),
                        Text(post.createdAt.toString())
                      ],
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
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        post.thumbnailImageRef,
                        // width: double.infinity,
                        // height: double.maxFinite,
                        fit: BoxFit.cover,
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
                      post.postTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      post.postDescription,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.favorite_border_outlined),
                          Icon(Icons.comment),
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
    );
  }
}
