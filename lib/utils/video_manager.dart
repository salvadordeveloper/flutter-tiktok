import 'package:flutter/material.dart';
import 'package:tiktok_flutter/models/video.dart';
import 'package:tiktok_flutter/screens/home.dart';
import 'package:video_player/video_player.dart';

class VideoManager {
  State<Home> state;
  Function updateController;

  List<Video> listVideos;
  var prevPage = 0;

  Sink<List<Video>> stream;

  VideoManager({this.stream});

  changeVideo(index) async {
    listVideos[prevPage].controller.pause();
    await loadVideo(index);
    listVideos[index].controller.play();

    //int prev = index > prevPage ? index - 2 : index + 2;
    //await disposeVideo(prevPage);

    prevPage = index;

    stream.add(listVideos);
  }

  Video getVideo(index) {
    return listVideos[index];
  }

  VideoPlayerController getController(index) {
    return listVideos[index].controller;
  }

  playVideo(index) {
    if (listVideos[index].controller != null) {
      listVideos[index].controller.play();
    }
  }

  pauseVideo(index) {
    if (listVideos[index].controller != null) {
      listVideos[index].controller.pause();
    }
  }

  loadVideo(index) async {
    if (listVideos[index].controller == null) {
      listVideos[index].controller =
          await createController(listVideos[index].url);
      stream.add(listVideos);
    }
  }

  disposeVideo(index) async {
    if (index >= 0) {
      if (listVideos[index].controller != null &&
          listVideos[index].controller.value.initialized) {
        await listVideos[index].controller.dispose();
        listVideos[index].controller = null;
      }
    }
  }

  Future<VideoPlayerController> createController(url) async {
    VideoPlayerController controller = VideoPlayerController.network(url);
    await controller.initialize();
    controller.setLooping(true);
    return controller;
  }

  bool hasVideos() {
    if (listVideos.length > 0) return true;
    return false;
  }

  int numOfVideos() {
    return listVideos.length;
  }

  dispose() {
    listVideos.forEach((element) {
      if (element.controller != null) {
        element.controller.dispose();
      }
    });
  }
}
