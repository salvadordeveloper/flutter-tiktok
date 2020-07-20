import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_flutter/models/video.dart';

import 'demo_data.dart';

class VideosAPI {
  VideosAPI();

  Future<List<Video>> getVideoListForUser(String userId) async {
    var data = await Firestore.instance.collection("Videos").getDocuments();

    if (data.documents.length == 0) {
      await addDemoData();
    }

    var videoList = <Video>[];
    var videos = await Firestore.instance.collection("Videos").getDocuments();

    videos.documents.forEach((element) {
      Video video = Video.fromJson(element.data);
      videoList.add(video);
    });

    return videoList;
  }

  Future<Null> addDemoData() async {
    for (var video in data) {
      await Firestore.instance.collection("Videos").add(video);
    }
  }

  //Working in User System
  Future<bool> removeVideosFromFeed(
      String userId, List<String> videoIds) async {
    await Firestore.instance
        .collection('Users')
        .document(userId)
        .updateData({"videosViewed": FieldValue.arrayUnion(videoIds)});
    return true;
  }

  Future<bool> clearHistory(String userId) async {
    var user =
        await Firestore.instance.collection('Users').document(userId).get();
    var listToRemove = user.data['videosViewed'];
    await Firestore.instance
        .collection('Users')
        .document(userId)
        .updateData({"videosViewed": FieldValue.arrayRemove(listToRemove)});
    return true;
  }
}
