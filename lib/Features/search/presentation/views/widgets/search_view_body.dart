import 'package:clean_arch_bookly_app/Features/home/presentation/manger/cubits/home_fetch_similar_books_cubit/home_fetch_similar_books_cubit.dart';
import 'package:clean_arch_bookly_app/Features/search/presentation/views/widgets/search_list_view_consumer.dart';
import 'package:clean_arch_bookly_app/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/styles.dart';
import 'custom_search_text_field.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  bool issubmited = false;
  String? title;
  String? titleChanged;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchTextField(
            onSubmitted: (p0) async {
              if (p0.isEmpty) {
                return customSnackBar(
                    context: context, text: 'title is required');
              }

              title = p0;
              setState(() {});
              await BlocProvider.of<HomeFetchSimilarBooksCubit>(context)
                  .fetchSimilarBooks(pageNumber: 0, bookTitle: title!);
            },
            onChanged: (p0) {
              titleChanged =p0;
            },
            onPressed: () async {
              if (titleChanged?.isEmpty??true) {
                return customSnackBar(
                    context: context, text: 'title is required');
              }
              if (titleChanged?.isNotEmpty ??false) {
                title =titleChanged;
                setState(() {
                  
                });
                await BlocProvider.of<HomeFetchSimilarBooksCubit>(context)
                    .fetchSimilarBooks(pageNumber: 0, bookTitle: title!);
              }
            },
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Search Result',
            style: Styles.textStyle18,
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: SearchListViewConsumer(
              title: title,
            ),
          ),
        ],
      ),
    );
  }
}
