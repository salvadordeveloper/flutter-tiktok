import 'package:flutter/services.dart';
import 'package:tiktok_flutter/data/videos_firebase.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class FeedViewModel extends BaseViewModel {
  VideoPlayerController controller;
  VideosAPI videoSource;

  int prevVideo = 0;

  int actualScreen = 0;

  FeedViewModel() {
    videoSource = VideosAPI();
  }

  changeVideo(index) async {
    videoSource.listVideos[prevVideo].controller.pause();
    if (videoSource.listVideos[index].controller == null) {
      await videoSource.listVideos[index].loadController();
    }
    videoSource.listVideos[index].controller.play();
    videoSource.listVideos[prevVideo].controller.removeListener(() {});

    //videoSource.listVideos[prevVideo].controller.dispose();

    prevVideo = index;
    notifyListeners();

    print(index);
  }

  void loadVideo(int index) async {
    await videoSource.listVideos[index].loadController();
    //videoSource.listVideos[index].controller.play();
    notifyListeners();
  }

  void setActualScreen(index) {
    actualScreen = index;
    if (index == 0) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
    notifyListeners();
  }
}
