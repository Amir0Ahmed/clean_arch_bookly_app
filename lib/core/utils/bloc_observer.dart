import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver implements BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    debugPrint('onEvent $event');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('onError $error   ,stackTrace $stackTrace');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint('onChange $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint('onTransition $transition');
  }

  @override
  void onClose(BlocBase bloc) {
    debugPrint('onClose $bloc');
  }

  @override
  void onCreate(BlocBase bloc) {
    debugPrint('onCreate $bloc');
  }
}
