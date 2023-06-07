import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    DateTime time = post.createdAt.toDate();
    String formattedDate = DateFormat("yyyy-MM-dd, kk:mm").format(time);

    return Padding(
      padding: const EdgeInsets.all(14.0),
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
                      children: [
                        SizedBox(
                          width: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.person_outline),
                              Text('@${post.username}', style: Theme.of(context).textTheme.bodyLarge,),
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
                      itemCount: post.categories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PillWidget(name: post.categories[index]),
                        );
                      },
                    ),
                  ),
                  Image.network(
                    post.thumbnailImageRef,
      
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        height: 50,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes !=
                                    null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return (const Center(
                        child: Text(
                            'Error Loading Image. Please Check Your Internet Connection...'),
                      ));
                    },
                    // width: double.infinity,
                    // height: double.maxFinite,
                    fit: BoxFit.cover,
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
                     Padding(
                      padding: EdgeInsets.only(top: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.favorite_border_outlined),
                                Text(post.likes.length.toString())
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }
}
