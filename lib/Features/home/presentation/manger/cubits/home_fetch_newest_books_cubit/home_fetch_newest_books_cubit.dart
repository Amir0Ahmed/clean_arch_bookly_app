import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/use_cases/home_fetch_newest_bokks_use_case.dart';
import 'package:clean_arch_bookly_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_fetch_newest_books_state.dart';

class HomeFetchNewestBooksCubit extends Cubit<HomeFetchNewestBooksState> {
  final HomeFetchNewestBooksUseCse _homeFetchNewestBooksUseCse;

  HomeFetchNewestBooksCubit(this._homeFetchNewestBooksUseCse)
      : super(HomeFetchNewestBooksInitial());

  Future<void> fetchNewestBooks({int pageNumber = 0}) async {
    if (pageNumber > 0) {
      emit(HomeFetchNewestBooksLoading());
    } else {
      emit(HomeFetchNewestBooksInitialLoading());
    }
    Either<Failure, List<BookEntity>> data =
        await _homeFetchNewestBooksUseCse.call(pageNumber);
    data.fold(
      (failure) {
        if (pageNumber > 0) {
          emit(
            HomeFetchNewestBooksFailureLoading(errMessage: failure.errMessage),
          );
        } else {
          emit(
            HomeFetchNewestBooksFailure(errMessage: failure.errMessage),
          );
        }
      },
      (books) {
        emit(
          HomeFetchNewestBooksSuccess(books: books),
        );
      },
    );
  }
}
