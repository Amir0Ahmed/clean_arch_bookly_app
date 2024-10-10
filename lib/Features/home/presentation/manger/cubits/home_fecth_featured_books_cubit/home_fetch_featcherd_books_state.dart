part of 'home_fetch_featcherd_books_cubit.dart';

@immutable
sealed class HomeFetchFeaturedBooksState {}

final class HomeFetchFeaturedBooksInitial extends HomeFetchFeaturedBooksState {}

final class HomeFetchFeaturedBooksLoading extends HomeFetchFeaturedBooksState {}

final class HomeFetchFeaturedBooksInitialLoading
    extends HomeFetchFeaturedBooksState {}

final class HomeFetchFeaturedBooksSuccess extends HomeFetchFeaturedBooksState {
  final List<BookEntity> books;

  HomeFetchFeaturedBooksSuccess({required this.books});
}

final class HomeFetchFeaturedBooksFailure extends HomeFetchFeaturedBooksState {
  final String errMessage;

  HomeFetchFeaturedBooksFailure({required this.errMessage});
}

final class HomeFetchFeaturedBooksFailureLoading
    extends HomeFetchFeaturedBooksState {
  final String errMessage;

  HomeFetchFeaturedBooksFailureLoading({required this.errMessage});
}
