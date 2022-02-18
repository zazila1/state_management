import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {
  const DescriptionText({Key? key, required this.label, required this.text}) : super(key: key);

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return text == ""
        ? const SizedBox.shrink()
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Text("$label:   "),
                Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          );
  }
}
