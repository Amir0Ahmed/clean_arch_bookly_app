import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/use_cases/home_fetch_featured_books_use_case.dart';
import 'package:clean_arch_bookly_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_fetch_featcherd_books_state.dart';

class HomeFetchFeaturedBooksCubit extends Cubit<HomeFetchFeaturedBooksState> {
  final HomeFetchFeaturedBooksUseCse _homeFetchFeaturedBooksUseCse;
  HomeFetchFeaturedBooksCubit(this._homeFetchFeaturedBooksUseCse)
      : super(HomeFetchFeaturedBooksInitial());

  Future<void> fetchFeaturedBooks({int pageNumber = 0}) async {

    if (pageNumber > 0) {
      emit(HomeFetchFeaturedBooksLoading());
    } else {
      emit(HomeFetchFeaturedBooksInitialLoading());
    }
    Either<Failure, List<BookEntity>> data =
        await _homeFetchFeaturedBooksUseCse.call(pageNumber);
    data.fold(
      (failure) {
        if (pageNumber > 0) {
          emit(
            HomeFetchFeaturedBooksFailureLoading(
                errMessage: failure.errMessage),
          );
        } else {
          emit(
            HomeFetchFeaturedBooksFailure(errMessage: failure.errMessage),
          );
        }
      },
      (books) => emit(
        HomeFetchFeaturedBooksSuccess(books: books),
      ),
    );
  }
}
