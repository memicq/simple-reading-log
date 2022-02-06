import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';

class RectangleImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;

  final bool syncBgColor;

  const RectangleImage({
    Key? key,
    required this.imageUrl,
    required this.height,
    required this.width,
    this.syncBgColor = false,
  }) : super(key: key);

  int abgrToArgb(int argbColor) {
    int r = (argbColor >> 16) & 0xFF;
    int b = argbColor & 0xFF;
    return (argbColor & 0xFF00FF00) | (b << 16) | r;
  }

  Future<int?> _getColor(String imageUrl) async {
    if (!syncBgColor) return null;

    Uint8List _values = (await NetworkAssetBundle(
      Uri.parse(imageUrl),
    ).load(
      imageUrl,
    ))
        .buffer
        .asUint8List();

    img.Image? image = img.decodeImage(_values);

    int? pixel32 = image?.getPixelSafe(0, 0);
    int? hex = pixel32 != null ? abgrToArgb(pixel32) : null;

    return hex;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getColor(imageUrl),
      builder: (context, snapshot) {
        int? colorHex = snapshot.data as int?;
        Color bgColor = colorHex == null ? Colors.grey.shade200 : Color(colorHex).withAlpha(100);

        return Container(
          color: bgColor,
          height: height,
          width: width,
          child: CachedNetworkImage(imageUrl: imageUrl),
        );
      },
    );
  }
}
