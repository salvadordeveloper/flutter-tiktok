
import 'package:tiktok_flutter/models/video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Video>> getVideoListForUser(String userId) async {

  var videoList = <Video>[];

  //Get UserID By Username
  var user = (await Firestore.instance.collection("Users").where("username", isEqualTo: userId).getDocuments()).documents[0];

  //Get List of Video ID's for the feed 
  var videosUser = await Firestore.instance.collection("Users").document(user.documentID).collection("VideoList").getDocuments();
  
  //Get videos from main list
  await Future.wait(videosUser.documents.map((element) async{
    var id = element.data['id'];
    var videoData = (await Firestore.instance.collection("Videos").document("AllVideos").collection("VideoList").where("id",isEqualTo: id).getDocuments()).documents[0];
    Video video = Video.fromJson(videoData.data);
    videoList.add(video);

  }));

  return videoList;
}

Future<bool> removeVideoFromFeed(String userId, String videoId) async{
  await Firestore.instance.collection("Users").document(userId).collection("VideoList").document(videoId).delete();
  return true;
}



