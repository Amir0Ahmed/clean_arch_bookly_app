import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/repos/home_repo.dart';
import 'package:clean_arch_bookly_app/core/errors/failure.dart';
import 'package:clean_arch_bookly_app/core/use_cases/use_case.dart';
import 'package:dartz/dartz.dart';

class HomeFetchNewestBooksUseCse extends UseCase<List<BookEntity>, int> {
  final HomeRepo homeRepo;

  HomeFetchNewestBooksUseCse({required this.homeRepo});
  @override
  Future<Either<Failure, List<BookEntity>>> call([int param = 0]) async {
    return await homeRepo.fetchNewestBooks(pageNumber: param);
  }
}
