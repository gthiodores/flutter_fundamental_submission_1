import 'package:flutter/material.dart';

class TwoTileText extends StatelessWidget {
  final String title;
  final String subtitle;
  final double titleSize;

  const TwoTileText({
    Key? key,
    required this.title,
    required this.subtitle,
    this.titleSize = 18.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: titleSize,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: const TextStyle(color: Colors.grey),
        )
      ],
    );
  }
}
