import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RectangleImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;

  const RectangleImage({
    Key? key,
    required this.imageUrl,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      height: height,
      width: width,
      child: CachedNetworkImage(imageUrl: imageUrl),
    );
  }
}
