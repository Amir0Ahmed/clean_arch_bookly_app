import 'dart:math';

import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeLocalDataSource {
  List<BookEntity> fetchFeaturedBooks({int pageNumber = 0}) {
    int startIndex = pageNumber * 10;
    int endIndex = (pageNumber + 1) * 10;
    int length = Hive.box<BookEntity>(kFeaturedBooksBox).values.length;
    endIndex = min(endIndex, length);
    if (startIndex >= length) {
      return [];
    }
    return Hive.box<BookEntity>(kFeaturedBooksBox)
        .values
        .toList()
        .sublist(startIndex, endIndex);
  }

  List<BookEntity> fetchNewestBooks({int pageNumber = 0}) {
    int startIndex = pageNumber * 10;
    int endIndex = (pageNumber + 1) * 10;
    int length = Hive.box<BookEntity>(kNewestBooksBox).values.length;
    endIndex = min(endIndex, length);
    if (startIndex >= length) {
      return [];
    }
    return Hive.box<BookEntity>(kNewestBooksBox)
        .values
        .toList()
        .sublist(startIndex, endIndex);
  }
}
