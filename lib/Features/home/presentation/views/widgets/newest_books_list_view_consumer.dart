import 'dart:developer';
import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/manger/cubits/home_fetch_newest_books_cubit/home_fetch_newest_books_cubit.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/widgets/newest_books_list_view.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/widgets/newest_books_list_view_shimmer_loading.dart';
import 'package:clean_arch_bookly_app/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewestBooksListViewConsumer extends StatelessWidget {
  const NewestBooksListViewConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    List<BookEntity> books = [];
    return BlocConsumer<HomeFetchNewestBooksCubit, HomeFetchNewestBooksState>(
      listener: (context, state) {
        if (state is HomeFetchNewestBooksSuccess) {
          books.addAll(state.books);
          log(books.length.toString());
        }
        if (state is HomeFetchNewestBooksFailure) {
          customSnackBar(context: context, text: state.errMessage);
        }
        if (state is HomeFetchNewestBooksFailureLoading) {
          customSnackBar(context: context, text: state.errMessage);
        }
      },
      builder: (context, state) {
        if (state is HomeFetchNewestBooksSuccess ||
            state is HomeFetchNewestBooksFailureLoading ||
            state is HomeFetchNewestBooksLoading) {
          return NewestBooksListView(
            books: books,
          );
        } else if (state is HomeFetchNewestBooksFailure) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .3,
            ),
          );
        } else {
          return const NewestBooksListViewShimmerLoading();
        }
      },
    );
  }
}
