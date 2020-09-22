import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_flutter/screens/feed_screen.dart';
import 'package:tiktok_flutter/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setup();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FeedScreen(),
  ));
}
