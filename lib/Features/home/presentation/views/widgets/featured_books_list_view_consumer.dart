import 'dart:developer';
import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/manger/cubits/home_fecth_featured_books_cubit/home_fetch_featcherd_books_cubit.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/widgets/featured_books_list_view_shimmer_loading.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/widgets/featured_list_view.dart';
import 'package:clean_arch_bookly_app/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeaturedBooksListViewConsumer extends StatelessWidget {
  const FeaturedBooksListViewConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    List<BookEntity> books = [];
    return BlocConsumer<HomeFetchFeaturedBooksCubit,
        HomeFetchFeaturedBooksState>(
      listener: (context, state) {
        if (state is HomeFetchFeaturedBooksSuccess) {
          books.addAll(state.books);
          log(books.length.toString());
        }
        if (state is HomeFetchFeaturedBooksFailure) {
          customSnackBar(context: context, text: state.errMessage);
        }
        if (state is HomeFetchFeaturedBooksFailureLoading) {
          customSnackBar(context: context, text: state.errMessage);
        }
      },
      builder: (context, state) {
        if (state is HomeFetchFeaturedBooksSuccess ||
            state is HomeFetchFeaturedBooksFailureLoading ||
            state is HomeFetchFeaturedBooksLoading) {
          return FeaturedBooksListView(
            books: books,
          );
        } else if (state is HomeFetchFeaturedBooksFailure) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .3,
          );
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .3,
            child: const FeaturedBooksListViewShimmerLoading(),
          );
        }
      },
    );
  }
}
