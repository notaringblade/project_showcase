import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project_showcase/widgets/text_widget.dart';

class StageOne extends StatefulWidget {
  const StageOne({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.image,
    required this.selectImage,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final Uint8List image;
  final Function selectImage;

  @override
  State<StageOne> createState() => _StageOneState();
}

class _StageOneState extends State<StageOne> {
  Uint8List? image;

  void changeThisImage() async {
    image = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () {
              try {
                widget.selectImage();
                changeThisImage();
              } catch (e) {}
            },
            child: image == null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary)),
                      height: 200,
                      width: double.infinity,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_outlined,
                            size: 48,
                          ),
                          Text('Choose Post thumbnail')
                        ],
                      ),
                    ),
                  )
                : SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(
                            image!,

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
                  )),
        SizedBox(
          height: 100,
        ),
        CustomTextField(
            textController: widget.titleController,
            hintText: "Enter Your Post's Title"),
        SizedBox(
          height: 25,
        ),
        SizedBox(
          child: CustomTextField(
              textController: widget.descriptionController,
              hintText: "Enter Your Post's Description"),
        ),
      ],
    );
  }
}
