import 'package:clean_arch_bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

void customSnackBar(
    {required BuildContext context,
    required String text,
    TextStyle style = Styles.textStyle16}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: const Color.fromARGB(255, 53, 52, 52),
      content: Text(
              text,
              style: style.copyWith(color: Colors.white),
            ),
    ),
  );
}
