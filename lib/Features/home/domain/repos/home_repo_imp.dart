import 'dart:developer';

import 'package:clean_arch_bookly_app/Features/home/data/data_sources/home_local_data_source.dart';
import 'package:clean_arch_bookly_app/Features/home/data/data_sources/home_remote_data_source.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/repos/home_repo.dart';
import 'package:clean_arch_bookly_app/constants.dart';
import 'package:clean_arch_bookly_app/core/errors/failure.dart';
import 'package:clean_arch_bookly_app/core/errors/server_failure.dart';
import 'package:clean_arch_bookly_app/core/utils/functions/save_data_in_hive.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImp implements HomeRepo {
  final HomeRemoteDataSource _homeRemoteDataSource;
  final HomeLocalDataSource _homeLocalDataSource;

  HomeRepoImp(this._homeRemoteDataSource, this._homeLocalDataSource);
  @override
  Future<Either<Failure, List<BookEntity>>> fetchFeaturedBooks(
      {int pageNumber = 0}) async {
    List<BookEntity> books;
    try {
      books = _homeLocalDataSource.fetchFeaturedBooks(pageNumber: pageNumber);
      if (books.isNotEmpty) {
        return Right(books);
      }
      books = await _homeRemoteDataSource.fetchFeaturedBooks(
          pageNumber: pageNumber);
      await saveDataInHive<BookEntity>(
          values: books, boxName: kFeaturedBooksBox);

      return Right(books);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      log(e.toString());
      return left(
        ServerFailure('Opps There was an Error, Please try again'),
      );
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> fetchNewestBooks(
      {int pageNumber = 0}) async {
    List<BookEntity> books;

    try {
      books = _homeLocalDataSource.fetchNewestBooks(pageNumber: pageNumber);
      if (books.isNotEmpty) {
        return Right(books);
      }
      books =
          await _homeRemoteDataSource.fetchNewestBooks(pageNumber: pageNumber);
      await saveDataInHive<BookEntity>(values: books, boxName: kNewestBooksBox);

      return Right(books);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(
        ServerFailure('Opps There was an Error, Please try again'),
      );
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> fetchSimilarBooks(
      {int pageNumber = 0, String bookTitle = 'programming'}) async {
    try {
      List<BookEntity> books = await _homeRemoteDataSource.fetchSimilarBooks(
          pageNumber: pageNumber,bookTitle: bookTitle);

      return Right(books);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      log(e.toString());
      return left(
        ServerFailure('Opps There was an Error, Please try again'),
      );
    }
  }
}
