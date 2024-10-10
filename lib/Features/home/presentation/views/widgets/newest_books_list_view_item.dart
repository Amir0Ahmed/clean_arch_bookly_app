import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/widgets/custom_book_item.dart';
import 'package:flutter/material.dart';
import '../../../../../constants.dart';
import '../../../../../core/utils/styles.dart';
import 'book_rating.dart';
class NewestBookListViewItem extends StatelessWidget {
  final BookEntity book;
  const NewestBookListViewItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: Row(
        children: [
          CustomBookImage(
            image: book.image,
            title: book.title,
          ),
          const SizedBox(
            width: 30,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .5,
                  child: Text(
                    book.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.textStyle20.copyWith(
                      fontFamily: kGtSectraFine,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  book.author ?? '',
                  style: Styles.textStyle14,
                         maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Text(
                      'free',
                      style: Styles.textStyle20.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                     BookRating(
                      pageNumber: book.pageNumber,
                      rating: book.rating,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
