import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'custom_book_item.dart';

class SimilarBooksListview extends StatelessWidget {
  const SimilarBooksListview({
    super.key, required this.books, this.scrollController,
  });
  final ScrollController? scrollController;
  final List<BookEntity> books;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .20,
      child: ListView.builder(
        controller: scrollController,
        itemCount: books.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GestureDetector(
                  onTap: () {
                  GoRouter.of(context)
                      .push(AppRouter.kBookDetailsView, extra: books[index]);
                },
                child: CustomBookImage(
                  image:books[index].image, title:books[index].author?? 'no title found',
                ),
              ),
            );
          }),
    );
  }
}
