import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'custom_snack_bar.dart';

Future<void> customlaunchUrl({required BuildContext context, String? url}) async {
  if (url != null) {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      log('Cannot launch $url');
      // ignore: use_build_context_synchronously
      customSnackBar(context: context, text:  'Cannot launch ');
    }
  }
}
