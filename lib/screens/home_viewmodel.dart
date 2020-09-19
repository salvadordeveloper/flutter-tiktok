import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';
import 'package:tiktok_flutter/data/videos_api.dart';
import 'package:tiktok_flutter/models/video.dart';
import 'package:tiktok_flutter/utils/video_manager.dart';

class HomeViewModel extends BaseViewModel {
  VideosAPI _videosAPI;
  VideoManager _videoManager;

  VideosAPI get videosAPI => _videosAPI;
  VideoManager get videosManager => _videoManager;

  HomeViewModel() {
    _videosAPI = VideosAPI();
    _videoManager = VideoManager(stream: listVideosEvent);
    loadVideos();
  }

  final BehaviorSubject<List<Video>> _listVideosController =
      new BehaviorSubject<List<Video>>.seeded(List<Video>());

  Stream<List<Video>> get listVideos => _listVideosController.stream;

  Sink<List<Video>> get listVideosEvent => _listVideosController.sink;

  List<Video> get videoList => _videoManager.listVideos;

  loadVideos() async {
    _videoManager.listVideos = await _videosAPI.getVideoListForUser("userTest");

    await _videoManager.loadVideo(0);
    _videoManager.playVideo(0);
    notifyListeners();
  }
}
