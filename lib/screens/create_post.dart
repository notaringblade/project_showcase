import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_showcase/models/user_model.dart';
import 'package:project_showcase/services/post_services.dart';
import 'package:project_showcase/utils/utils.dart';
import 'package:project_showcase/widgets/text_widget.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key, required this.user}) : super(key: key);

  final UserModel user;

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController thumbnailImageContoller = TextEditingController();

  PostServices postServices = PostServices();

  List<Uint8List> images = [];

  Utils utils = Utils();

  Uint8List? image;

  final user = FirebaseAuth.instance.currentUser!;
  void selectImage() async {
    try {
      Uint8List file = await utils.pickImage(ImageSource.gallery);

      setState(() {
        image = file;
      });
    } catch (e) {
      print(e);
    }
  }

  void addImageToList() async {
    Uint8List file = await utils.pickImage(ImageSource.gallery);
    if (images.length < 6) {
      setState(() {
        images.add(file);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Create Post", style: Theme.of(context).textTheme.titleLarge),
        backgroundColor: Colors.transparent,
        // centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  if (titleController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty) {
                    setState(() {
                      postServices.createPost(
                          titleController.text,
                          descriptionController.text,
                          widget.user.username,
                          widget.user.uid,
                          image!,
                          images,
                          context);
                      titleController.text = '';
                      thumbnailImageContoller.text = '';
                      descriptionController.text = '';
                    });
                  }
                },
                child: Icon(Icons.add)),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomTextField(
              textController: titleController,
              hintText: "Enter Your Post's Title"),
          SizedBox(
            height: 5,
          ),
          CustomTextField(
              textController: descriptionController,
              hintText: "Enter Your Post's Description"),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
              onTap: () => selectImage(),
              child: image == null
                  ? SizedBox(
                      height: 100,
                      width: 100,
                      child: Icon(
                        Icons.image_outlined,
                        size: 48,
                      ),
                    )
                  : SizedBox(
                      height: 200,
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
            height: 25,
          ),
          GestureDetector(
              onTap: () {
                addImageToList();
              },
              child: Icon(
                Icons.add,
                size: 32,
              )),
          Expanded(
            child: ListView.builder(
              // shrinkWrap: true,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.memory(images[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
