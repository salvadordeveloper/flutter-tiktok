import 'package:tiktok_flutter/models/video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Video>> getVideoListForUser(String userId) async {
  var videoList = <Video>[];

  var videos = await Firestore.instance
      .collection("Videos")
      .document("AllVideos")
      .collection("VideoList")
      .getDocuments();

  videos.documents.forEach((element) {
    Video video = Video.fromJson(element.data);
    videoList.add(video);
  });

  var userData = await Firestore.instance
      .collection("Users")
      .where("username", isEqualTo: userId)
      .getDocuments();

  var videosViewed = userData.documents[0].data['videosViewed'];

  Map<String, bool> videosV = Map();

  videosViewed.forEach((video) {
    videosV[video] = true;
  });

  var filteredVideos = <Video>[];

  videoList.forEach((element) {
    if (videosV[element.id] == null || videosV[element.id] == false) {
      filteredVideos.add(element);
    }
  });

  return filteredVideos;
}

Future<bool> removeVideosFromFeed(String userId, List<String> videoIds) async {
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
