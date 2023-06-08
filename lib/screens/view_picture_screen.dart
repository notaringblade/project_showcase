import 'package:flutter/material.dart';

class ViewPictureScreen extends StatelessWidget {
  const ViewPictureScreen({Key? key, required this.imageRef}) : super(key: key);

  final String imageRef;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(imageRef),
          ),
        ),
      ),
    );
  }
}
