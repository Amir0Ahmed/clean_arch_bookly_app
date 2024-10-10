import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/repos/home_repo_imp.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/use_cases/home_fetch_similar_books_use_case.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/manger/cubits/home_fetch_similar_books_cubit/home_fetch_similar_books_cubit.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/book_details_view.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/home_view.dart';
import 'package:clean_arch_bookly_app/Features/search/presentation/views/search_view.dart';
import 'package:clean_arch_bookly_app/core/utils/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../Features/Splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const kHomeView = '/homeView';
  static const kBookDetailsView = '/bookDetailsView';
  static const kSearchView = '/searchView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kSearchView,
        builder: (context, state) => BlocProvider(
          create: (context) => HomeFetchSimilarBooksCubit(
            HomeFetchSimilarBooksUseCse(
              homeRepo: getIt<HomeRepoImp>(),
            ),
          ),
          child: const SearchView(),
        ),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: kBookDetailsView,
        builder: (BuildContext context, GoRouterState state) => BlocProvider(
          create: (context) => HomeFetchSimilarBooksCubit(
            HomeFetchSimilarBooksUseCse(
              homeRepo: getIt<HomeRepoImp>(),
            ),
          ),
          child: BookDetailsView(
            book: state.extra as BookEntity,
          ),
        ),
      ),
    ],
  );
}
