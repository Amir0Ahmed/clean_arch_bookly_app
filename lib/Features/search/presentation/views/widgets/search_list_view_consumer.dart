import 'dart:developer';

import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/manger/cubits/home_fetch_similar_books_cubit/home_fetch_similar_books_cubit.dart';
import 'package:clean_arch_bookly_app/Features/search/presentation/views/widgets/search_list_view.dart';
import 'package:clean_arch_bookly_app/Features/search/presentation/views/widgets/search_list_view_shimmer_loading.dart';
import 'package:clean_arch_bookly_app/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchListViewConsumer extends StatelessWidget {
  const SearchListViewConsumer({
    super.key,
    required this.title,
  });
  final String? title;
  @override
  Widget build(BuildContext context) {
    List<BookEntity> books = [];

    return BlocConsumer<HomeFetchSimilarBooksCubit, HomeFetchSimilarBooksState>(
      listener: (context, state) {
        if (state is HomeFetchSimilarBooksSuccessInitial) {
          books = state.books;
          log(books.length.toString());
        }
        if (state is HomeFetchSimilarBooksSuccess) {
          books.addAll(state.books);
          log(books.length.toString());
        }
        if (state is HomeFetchSimilarBooksFailure) {
          customSnackBar(context: context, text: state.errMessage);
        }
        if (state is HomeFetchSimilarBooksFailureLoading) {
          customSnackBar(context: context, text: state.errMessage);
        }
      },
      builder: (context, state) {
        if (state is HomeFetchSimilarBooksSuccess ||
            state is HomeFetchSimilarBooksFailureLoading ||
            state is HomeFetchSimilarBooksLoading ||
            state is HomeFetchSimilarBooksSuccessInitial) {
          return SearchListView(
            title: title,
            books: books,
          );
        } else if (state is HomeFetchSimilarBooksFailure) {
          return const SizedBox.shrink();
        } else if (state is HomeFetchSimilarBooksInitialLoading) {
          return const SearchListViewShimmerLoading();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
