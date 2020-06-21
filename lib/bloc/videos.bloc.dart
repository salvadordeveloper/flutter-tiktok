

import 'package:rxdart/rxdart.dart';
import 'package:tiktok_flutter/data/videos_api.dart';
import 'package:tiktok_flutter/models/video.dart';
import 'package:tiktok_flutter/utils/video_manager.dart';

class VideosBloc{

  final VideosAPI _videosAPI;
  VideoManager videoManager;

  VideosBloc(this._videosAPI){
    videoManager = VideoManager(stream:this.listVideosEvent);
    loadVideos();
  }
  
  final BehaviorSubject<List<Video>> _listVideosController =
      new BehaviorSubject<List<Video>>.seeded(List<Video>());

  Stream<List<Video>> get listVideos =>
      _listVideosController.stream;

  Sink<List<Video>> get listVideosEvent => _listVideosController.sink;

  List<Video> get videoList => videoManager.listVideos;

  loadVideos() async{
    videoManager.listVideos = await _videosAPI.getVideoListForUser("userTest"); 
    await videoManager.loadVideo(0);
    videoManager.playVideo(0);

    //listVideosEvent.add(_videoList);
  }

}