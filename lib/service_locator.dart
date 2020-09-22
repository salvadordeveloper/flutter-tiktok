import 'package:tiktok_flutter/screens/feed_viewmodel.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerSingleton<FeedViewModel>(FeedViewModel());
}
