import 'package:clean_arch_bookly_app/Features/home/data/models/param_model.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/repos/home_repo.dart';
import 'package:clean_arch_bookly_app/core/errors/failure.dart';
import 'package:clean_arch_bookly_app/core/use_cases/use_case.dart';
import 'package:dartz/dartz.dart';

class HomeFetchSimilarBooksUseCse
    extends UseCase<List<BookEntity>, ParamModel?> {
  final HomeRepo homeRepo;

  HomeFetchSimilarBooksUseCse({required this.homeRepo});

  @override
  // ignore: avoid_renaming_method_parameters
  Future<Either<Failure, List<BookEntity>>> call([ParamModel? paramModel]) {
    return homeRepo.fetchSimilarBooks(
        pageNumber: paramModel?.pageNum ?? 0,
        bookTitle: paramModel?.bookSimilar ?? 'programming');
  }
}
