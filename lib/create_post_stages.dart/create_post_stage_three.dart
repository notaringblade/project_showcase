import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_showcase/widgets/pill_widget.dart';
import 'package:project_showcase/widgets/text_widget.dart';

class CreatePostStageThree extends StatefulWidget {
  const CreatePostStageThree(
      {Key? key, required this.addCategories, required this.categories})
      : super(key: key);

  final List<String> categories;
  final Function addCategories;

  @override
  _CreatePostStageThreeState createState() => _CreatePostStageThreeState();
}

class _CreatePostStageThreeState extends State<CreatePostStageThree> {
  TextEditingController categoryEditor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Text(
          "Choose Categories for your post",
          style: Theme.of(context).textTheme.titleMedium,
        )),
        SizedBox(
          height: 10,
        ),
        CustomTextField(
            textController: categoryEditor,
            hintText: "Enter a category for your post"),
        GestureDetector(
            onTap: () {
              if (categoryEditor.text.isNotEmpty) {
                setState(() {
                  widget.addCategories(categoryEditor.text.toLowerCase().trim());
                  categoryEditor.text = '';
                });
              }
            },
            child: Icon(Icons.add)),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: () {
                  setState(() {
                    widget.categories.removeAt(index);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PillWidget(name: widget.categories[index], active: false),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
