import 'package:flutter/material.dart';

class PillWidget extends StatelessWidget {
  const PillWidget({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.secondary),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            name,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
