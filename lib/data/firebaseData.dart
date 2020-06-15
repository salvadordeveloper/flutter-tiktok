

import 'package:firebase_database/firebase_database.dart';
import 'package:tiktok_flutter/models/video.dart';

Future<List<Video>> getVideoList() async {

    Map<dynamic, dynamic> values = await (await FirebaseDatabase.instance.reference().child("videos").once()).value;
    var videoList = <Video>[];

    values.forEach((key, video) {
      videoList.add(Video.fromJson(video));
    });  

    return videoList;
  }