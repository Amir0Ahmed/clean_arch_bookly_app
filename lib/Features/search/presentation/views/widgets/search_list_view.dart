import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/manger/cubits/home_fetch_similar_books_cubit/home_fetch_similar_books_cubit.dart';
import 'package:clean_arch_bookly_app/Features/search/presentation/views/widgets/search_list_view_item.dart';
import 'package:clean_arch_bookly_app/core/utils/app_router.dart';
import 'package:clean_arch_bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchListView extends StatefulWidget {
  const SearchListView({
    super.key,
    this.books,
    required this.title,
  });
  final List<BookEntity>? books;
  final String? title;
  @override
  State<SearchListView> createState() => _SearchListViewState();
}

class _SearchListViewState extends State<SearchListView> {
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
          await BlocProvider.of<HomeFetchSimilarBooksCubit>(context)
              .fetchSimilarBooks(
                  pageNumber: nextPage++, bookTitle: widget.title!);

          isLoading = false;
        }
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
    if (widget.books?.isEmpty ?? true) {
      return const Center(
          child: Text(
        'no books found',
        style: Styles.textStyle30,
      ));
    }
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.books?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            GoRouter.of(context)
                .push(AppRouter.kBookDetailsView, extra: widget.books![index]);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SearchListViewItem(book: widget.books![index]),
          ),
        );
      },
    );
  }
}
