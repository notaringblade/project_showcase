import 'package:flutter/material.dart';
import 'package:project_showcase/models/post_model.dart';

class MiniPostWidget extends StatelessWidget {
  const MiniPostWidget({Key? key, required this.post}) : super(key: key);

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.secondary, width: 2),
                  borderRadius: BorderRadius.circular(8)),
              height: 240,
              width: double.infinity,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child:
                      Image.network(post.thumbnailImageRef, fit: BoxFit.cover)),
            ),
          ),
          
        ],
      ),
    );
  }
}
