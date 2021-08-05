import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:hive/hive.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

Future<void> mainServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox('bookmarked_articles');
  await Hive.openBox('bookmarked_videos');
  await Hive.openBox('articles_details');
  await Firebase.initializeApp();
}
