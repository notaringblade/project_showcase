import 'dart:typed_data';

import 'package:flutter/material.dart';

class StageTwo extends StatefulWidget {
  const StageTwo({
    super.key,
    required this.images,
    required this.selectImages,
  });

  final List<Uint8List> images;
  final Function selectImages;

  @override
  State<StageTwo> createState() => _StageTwoState();
}

class _StageTwoState extends State<StageTwo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              widget.selectImages();
            },
            child: const Icon(
              Icons.add,
              size: 32,
            )),
        Expanded(
          child: ListView.builder(
            // shrinkWrap: true,
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 150,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.memory(widget.images[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
