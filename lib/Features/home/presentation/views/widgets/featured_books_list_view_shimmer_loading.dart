import 'package:clean_arch_bookly_app/core/widgets/skelton.dart';
import 'package:flutter/material.dart';

class FeaturedBooksListViewShimmerLoading extends StatelessWidget {
  const FeaturedBooksListViewShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: AspectRatio(
              aspectRatio: 2.6 / 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: const Skelton(),
              ),
            ),
          );
        });
  }
}
