import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomBookImage extends StatelessWidget {
  const CustomBookImage({super.key, this.image, this.title});
  final String? image;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.6 / 4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: image == null
            ? Container(
                color: const Color.fromARGB(255, 74, 72, 72),
                child: Center(
                  child: Text(
                    title ?? 'no title found',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : CachedNetworkImage(
                imageUrl: image!,
                fit: BoxFit.fill,
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  size: 50,
                ),
              ),
      ),
    );
  }
}
