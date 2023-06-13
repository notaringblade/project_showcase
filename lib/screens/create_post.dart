import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_showcase/create_post_stages.dart/create_post_stage_three.dart';
import 'package:project_showcase/create_post_stages.dart/create_post_stage_two.dart';
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
  List<String> categories = [];

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

  void addCategories(String category) {
    if (!categories.contains(category)) {
      categories.add(category);
    }
  }

  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

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
            child: GestureDetector(child: Icon(Icons.add)),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
                // allowImplicitScrolling: false,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                    print(currentPage);
                  });
                },
                physics: NeverScrollableScrollPhysics(),
                controller: pageController,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: image == null
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary)),
                                      height: 200,
                                      width: double.infinity,
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.memory(
                                            image!,

                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              print(error);
                                              return (const Center(
                                                child: Text(
                                                    'This Image is Invalid'),
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
                            textController: titleController,
                            hintText: "Enter Your Post's Title"),
                        SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          child: CustomTextField(
                              textController: descriptionController,
                              hintText: "Enter Your Post's Description"),
                        ),
                      ],
                    ),
                  ),
                  StageTwo(
                    images: images,
                    selectImages: addImageToList,
                  ),
                  CreatePostStageThree(
                      addCategories: addCategories, categories: categories)
                ]),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
                height: 100,
                width: 250,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        currentPage != 0
                            ? GestureDetector(
                                onTap: () {
                                  pageController.previousPage(
                                      duration: Duration(milliseconds: 200),
                                      curve: Curves.easeIn);
                                },
                                child: Text('Back'),
                              )
                            : Container(),
                        currentPage != 2
                            ? GestureDetector(
                                onTap: () {
                                  pageController.nextPage(
                                      duration: Duration(milliseconds: 200),
                                      curve: Curves.easeIn);
                                },
                                child: Text('Next'),
                              )
                            : GestureDetector(
                                onTap: () {
                                  if (titleController.text.isNotEmpty &&
                                      descriptionController.text.isNotEmpty) {
                                    setState(() {
                                      try {
                                        postServices.createPost(
                                            titleController.text,
                                            descriptionController.text,
                                            widget.user.username,
                                            widget.user.uid,
                                            categories,
                                            image!,
                                            images,
                                            context);
                                        titleController.text = '';
                                        thumbnailImageContoller.text = '';
                                        descriptionController.text = '';
                                      } catch (e) {
                                        showCupertinoModalPopup(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Text(
                                                  "Please Choose A Thumbnail Image To Make A Post"),
                                            );
                                          },
                                        );
                                      }
                                    });

                                    // Navigator.pop(context);
                                  }
                                },
                                child: Text('Post')),
                      ],
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
