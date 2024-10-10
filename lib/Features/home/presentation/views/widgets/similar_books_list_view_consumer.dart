import 'dart:developer';

import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/manger/cubits/home_fetch_similar_books_cubit/home_fetch_similar_books_cubit.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/widgets/featured_books_list_view_shimmer_loading.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/widgets/similar_books_list_view.dart';
import 'package:clean_arch_bookly_app/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimilarBooksListViewConsumer extends StatefulWidget {
  const SimilarBooksListViewConsumer({super.key, required this.book});
  final BookEntity book;

  @override
  State<SimilarBooksListViewConsumer> createState() =>
      _SimilarBooksListViewConsumerState();
}

class _SimilarBooksListViewConsumerState
    extends State<SimilarBooksListViewConsumer> {
  int nextPage = 0;
  late ScrollController _scrollController;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    fetchBooks(pageNumber: nextPage++, bookTitle: widget.book.title);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      _scrollListener();
    });
  }

  Future<void> _scrollListener() async {
    double currentPosition = _scrollController.position.pixels;
    double maxScrollLength = _scrollController.position.maxScrollExtent;
    if (currentPosition >= maxScrollLength * 0.7) {
      if (!isLoading) {
        isLoading = true;
        await Future.delayed(const Duration(microseconds: 500));

        await fetchBooks(pageNumber: nextPage++, bookTitle: widget.book.title);
        isLoading = false;
      }
    }
  }

  Future<void> fetchBooks(
      {required int pageNumber, required String bookTitle}) async {
    await BlocProvider.of<HomeFetchSimilarBooksCubit>(context)
        .fetchSimilarBooks(pageNumber: pageNumber, bookTitle: bookTitle);
  }

  @override
  @override
  void dispose() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   _snackbarManager.removeCurrentSnackBar();
    // });
    _scrollController.dispose();

    super.dispose();
  }

  List<BookEntity> books = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeFetchSimilarBooksCubit, HomeFetchSimilarBooksState>(
      listener: (context, state) {
        if (state is HomeFetchSimilarBooksSuccessInitial) {
          books.addAll(state.books);
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
          return SimilarBooksListview(
            books: books,
            scrollController: _scrollController,
          );
        } else if (state is HomeFetchSimilarBooksFailure) {
          return const SizedBox.shrink();
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .18,
            child: const FeaturedBooksListViewShimmerLoading(),
          );
        }
      },
    );
  }
}
