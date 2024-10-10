import 'package:hive_flutter/hive_flutter.dart';

Future<void> saveDataInHive<boxType>(
    {required Iterable<boxType> values, required String boxName}) async {
  var box = Hive.box<boxType>(boxName);
  await box.addAll(values);
}
