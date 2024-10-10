import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/manger/cubits/home_fecth_featured_books_cubit/home_fetch_featcherd_books_cubit.dart';
import 'package:clean_arch_bookly_app/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'custom_book_item.dart';

class FeaturedBooksListView extends StatefulWidget {
  final List<BookEntity> books;
  const FeaturedBooksListView({
    super.key,
    required this.books,
  });

  @override
  State<FeaturedBooksListView> createState() => _FeaturedBooksListViewState();
}

class _FeaturedBooksListViewState extends State<FeaturedBooksListView> {
  int nextPage = 1;
  late ScrollController _scrollController;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
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
        if (mounted) {
          await BlocProvider.of<HomeFetchFeaturedBooksCubit>(context)
              .fetchFeaturedBooks(pageNumber: nextPage++);
        }
        isLoading = false;
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .3,
      child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: widget.books.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kBookDetailsView,
                      extra: widget.books[index]);
                },
                child: CustomBookImage(
                  image: widget.books[index].image,
                  title: widget.books[index].title,
                ),
              ),
            );
          }),
    );
  }
}
