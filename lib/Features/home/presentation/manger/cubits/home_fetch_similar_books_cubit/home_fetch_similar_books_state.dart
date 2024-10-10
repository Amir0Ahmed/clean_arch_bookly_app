part of 'home_fetch_similar_books_cubit.dart';


@immutable
sealed class HomeFetchSimilarBooksState {}

final class HomeFetchSimilarBooksInitial extends HomeFetchSimilarBooksState {}

final class HomeFetchSimilarBooksLoading extends HomeFetchSimilarBooksState {}

final class HomeFetchSimilarBooksInitialLoading
    extends HomeFetchSimilarBooksState {}

final class HomeFetchSimilarBooksSuccess extends HomeFetchSimilarBooksState {
  final List<BookEntity> books;

  HomeFetchSimilarBooksSuccess({required this.books});
}
final class HomeFetchSimilarBooksSuccessInitial extends HomeFetchSimilarBooksState {
  final List<BookEntity> books;

  HomeFetchSimilarBooksSuccessInitial({required this.books});
}

final class HomeFetchSimilarBooksFailure extends HomeFetchSimilarBooksState {
  final String errMessage;

  HomeFetchSimilarBooksFailure({required this.errMessage});
}

final class HomeFetchSimilarBooksFailureLoading
    extends HomeFetchSimilarBooksState {
  final String errMessage;

  HomeFetchSimilarBooksFailureLoading({required this.errMessage});
}
