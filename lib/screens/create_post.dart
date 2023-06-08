import 'package:flutter/material.dart';
import 'package:project_showcase/models/user_model.dart';
import 'package:project_showcase/services/post_services.dart';
import 'package:project_showcase/widgets/custom_button.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Create Post", style: Theme.of(context).textTheme.titleLarge),
        backgroundColor: Colors.transparent,
        // centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
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
              CustomTextField(
                  textController: thumbnailImageContoller,
                  hintText: "Enter Your Post's image link"),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                  onTap: () {
                    if (titleController.text.isNotEmpty &&
                        thumbnailImageContoller.text.isNotEmpty &&
                        descriptionController.text.isNotEmpty) {
                      setState(() {
                        postServices.createPost(
                            titleController.text,
                            descriptionController.text,
                            widget.user.username,
                            widget.user.uid,
                            thumbnailImageContoller.text,
                            context);
                        titleController.text = '';
                        thumbnailImageContoller.text = '';
                        descriptionController.text = '';
                      });
                    }
                  },
                  child: CustomButton(buttonText: 'Post'))
            ],
          ),
        ),
      ),
    );
  }
}
