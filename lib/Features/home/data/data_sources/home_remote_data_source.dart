// ignore_for_file: missing_required_param
import 'dart:developer';
import 'package:clean_arch_bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/core/utils/api_service.dart';

class HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSource({required this.apiService});

  Future<List<BookEntity>> fetchFeaturedBooks({int pageNumber = 0}) async {
    Map<String, dynamic> data = await apiService.getRequest(
      endPoint:
          'volumes?Filtering=free-ebooks&q=programming&startIndex=${pageNumber * 10}',
    );
    // log(pageNumber.toString());

    return fetchBooks(data);
  }

  Future<List<BookEntity>> fetchNewestBooks({int pageNumber = 0}) async {
    Map<String, dynamic> data = await apiService.getRequest(
      endPoint:
          'volumes?Filtering=free-ebooks&q=programming&Sorting=newest&startIndex=${pageNumber * 10}',
    );
    log(pageNumber.toString());
    return fetchBooks(data);
  }

  Future<List<BookEntity>> fetchSimilarBooks(
      {int pageNumber = 0, String bookTitle = 'programming'}) async {
    Map<String, dynamic> data = await apiService.getRequest(
      endPoint:
          // ignore: unnecessary_brace_in_string_interps
          'volumes?Filtering=free-ebooks&q=${bookTitle}&Sorting=newest&startIndex=${pageNumber * 10}',
    );
    // log(pageNumber.toString());
    return fetchBooks(data);
  }

  List<BookEntity> fetchBooks(Map<String, dynamic> data) {
    List<BookEntity> books = [];
    List<dynamic>? fetchedBooks = data['items'];
    if (fetchedBooks?.isEmpty ?? true) {
      // log('empty items');
      return books;
    }

    for (var book in fetchedBooks!) {
      books.add(BookModel.fromJson(book));
    }
    return books;
  }
}
