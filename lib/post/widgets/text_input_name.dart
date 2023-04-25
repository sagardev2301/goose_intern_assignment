import 'package:flutter/material.dart';


class TextInputName extends StatelessWidget {
  const TextInputName({
    Key? key,
    required this.name,
  }) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
