import 'package:flutter/material.dart';
import 'package:flutter_image/flutter_image.dart';

class CustomImage extends StatelessWidget {
  final String url;
  final BoxFit? fit;

  const CustomImage({
    Key? key,
    required this.url,
    required this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Image(
        image: NetworkImageWithRetry(
          url,
          fetchStrategy: const FetchStrategyBuilder(
            maxAttempts: 3,
          ).build(),
        ),
        errorBuilder: (buildContext, exception, stackTrace) {
          return Image.asset('assets/images/food.png');
        },
        fit: fit,
      ),
      height: 80,
    );
  }
}
