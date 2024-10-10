part of 'home_fetch_newest_books_cubit.dart';

@immutable
sealed class HomeFetchNewestBooksState {}

final class HomeFetchNewestBooksInitial extends HomeFetchNewestBooksState {}

final class HomeFetchNewestBooksLoading extends HomeFetchNewestBooksState {}

final class HomeFetchNewestBooksInitialLoading
    extends HomeFetchNewestBooksState {}

final class HomeFetchNewestBooksSuccess extends HomeFetchNewestBooksState {
  final List<BookEntity> books;

  HomeFetchNewestBooksSuccess({required this.books});
}

final class HomeFetchNewestBooksFailure extends HomeFetchNewestBooksState {
  final String errMessage;

  HomeFetchNewestBooksFailure({required this.errMessage});
}

final class HomeFetchNewestBooksFailureLoading
    extends HomeFetchNewestBooksState {
  final String errMessage;

  HomeFetchNewestBooksFailureLoading({required this.errMessage});
}
