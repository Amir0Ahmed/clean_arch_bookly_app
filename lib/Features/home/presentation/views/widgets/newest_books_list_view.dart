import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'newest_books_list_view_item.dart';

class NewestBooksListView extends StatelessWidget {
  final List<BookEntity> books;

  const NewestBooksListView({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: books.length,
      itemBuilder: (context,index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: GestureDetector(
              onTap: () {
                GoRouter.of(context)
                    .push(AppRouter.kBookDetailsView, extra: books[index]);
              },
              child: NewestBookListViewItem(
                book: books[index],
              )),
        );
      },
    );
  }
}
