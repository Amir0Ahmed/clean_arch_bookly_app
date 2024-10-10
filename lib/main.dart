import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/repos/home_repo_imp.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/use_cases/home_fetch_featured_books_use_case.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/use_cases/home_fetch_newest_bokks_use_case.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/manger/cubits/home_fecth_featured_books_cubit/home_fetch_featcherd_books_cubit.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/manger/cubits/home_fetch_newest_books_cubit/home_fetch_newest_books_cubit.dart';
import 'package:clean_arch_bookly_app/constants.dart';
import 'package:clean_arch_bookly_app/core/utils/app_router.dart';
import 'package:clean_arch_bookly_app/core/utils/bloc_observer.dart';
import 'package:clean_arch_bookly_app/core/utils/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(BookEntityAdapter());
  await Hive.openBox<BookEntity>(kFeaturedBooksBox);
  await Hive.openBox<BookEntity>(kNewestBooksBox);
  await Hive.openBox<BookEntity>(kSimilarBooksBox);
  Bloc.observer = MyBlocObserver();
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeFetchFeaturedBooksCubit(
            HomeFetchFeaturedBooksUseCse(
              homeRepo: getIt<HomeRepoImp>(),
            ),
          )..fetchFeaturedBooks(),
        ),
        BlocProvider(
          create: (context) => HomeFetchNewestBooksCubit(
            HomeFetchNewestBooksUseCse(
              homeRepo: getIt<HomeRepoImp>(),
            ),
          )..fetchNewestBooks(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kPrimaryColor,
          textTheme:
              GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
        ),
      ),
    );
  }
}
