import 'package:flutter/cupertino.dart';
import 'package:project_showcase/widgets/pill_widget.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    super.key,
    required this.categories,
    required this.selectedCategories,
  });

  final List<String> categories;
  final List<String> selectedCategories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  // setState(() {
                  //   if (selectedCategories.contains(
                  //       categories[index].trim().toLowerCase())) {
                  //     selectedCategories.remove(
                  //         categories[index].trim().toLowerCase());
                  //   } else {
                  //     selectedCategories.add(
                  //         categories[index].trim().toLowerCase());
                  //   }
                  // });
                },
                child: PillWidget(
                  name: categories[index],
                  active: selectedCategories.contains(categories[index]),
                )),
          );
        },
      ),
    );
  }
}
