import 'package:hive_flutter/hive_flutter.dart';

part 'book_entity.g.dart';

@HiveType(typeId: 1)
class BookEntity extends HiveObject {
  @HiveField(0)
  final String? image;
  @HiveField(1)
  final String? author;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String bookId;
  @HiveField(4)
  final num? price;
  @HiveField(5)
  final num? rating;
  @HiveField(6)
  final int? pageNumber;
  @HiveField(7)
  final String? previewLink;
  BookEntity({
    required this.bookId,
    this.image,
    this.author,
    required this.title,
    this.price,
    this.rating,
    this.pageNumber,
    this.previewLink,
  });
}
