import 'package:clean_arch_bookly_app/Features/home/data/models/param_model.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/use_cases/home_fetch_similar_books_use_case.dart';
import 'package:clean_arch_bookly_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_fetch_similar_books_state.dart';

class HomeFetchSimilarBooksCubit extends Cubit<HomeFetchSimilarBooksState> {
  final HomeFetchSimilarBooksUseCse _homeFetchSimilarBooksUseCse;

  HomeFetchSimilarBooksCubit(this._homeFetchSimilarBooksUseCse)
      : super(HomeFetchSimilarBooksInitial());
// List<BookEntity> books=[];
  Future<void> fetchSimilarBooks(
      {int pageNumber = 0, String bookTitle = 'programming'}) async {
    if (pageNumber > 0) {
      emit(HomeFetchSimilarBooksLoading());
    } else {
      emit(HomeFetchSimilarBooksInitialLoading());
    }
    Either<Failure, List<BookEntity>> data = await _homeFetchSimilarBooksUseCse
        .call(ParamModel(pageNum: pageNumber, bookSimilar: bookTitle));
    data.fold(
      (failure) {
        if (pageNumber > 0) {
          emit(
            HomeFetchSimilarBooksFailureLoading(errMessage: failure.errMessage),
          );
        } else {
          emit(
            HomeFetchSimilarBooksFailure(errMessage: failure.errMessage),
          );
        }
      },
      (booksList) {
        // for (var element in booksList) {
        //   books.add(element);
        // }
        if (pageNumber > 0) {
          emit(
            HomeFetchSimilarBooksSuccess(books: booksList),
          );
        } else {
          emit(
            HomeFetchSimilarBooksSuccessInitial(books: booksList),
          );
        }
      },
    );
  }
}
