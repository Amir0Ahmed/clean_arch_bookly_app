import 'package:clean_arch_bookly_app/Features/home/presentation/manger/cubits/home_fetch_newest_books_cubit/home_fetch_newest_books_cubit.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/widgets/featured_books_list_view_consumer.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/widgets/newest_books_list_view_consumer.dart';
import 'package:clean_arch_bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_app_bar.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  int nextPage = 1;
  late ScrollController scrollController;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      _scrollListener();
    });
  }

  Future<void> _scrollListener() async {
    double currentPosition = scrollController.position.pixels;
    double maxScrollLength = scrollController.position.maxScrollExtent;
    if (currentPosition >= maxScrollLength * .7) {
      if (!isLoading) {
        isLoading = true;
        await Future.delayed(const Duration(microseconds: 500));
        if (mounted) {
          await BlocProvider.of<HomeFetchNewestBooksCubit>(context)
              .fetchNewestBooks(pageNumber: nextPage++);
          isLoading = false;
        }
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: const [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: CustomAppBar()),
              FeaturedBooksListViewConsumer(),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Newest Books',
                  style: Styles.textStyle18,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        NewestBooksListViewConsumer(),
      ],
    );
  }
}
