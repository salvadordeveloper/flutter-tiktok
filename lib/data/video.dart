import 'package:video_player/video_player.dart';

class Video {
  String id;
  String user;
  String userPic;
  String videoTitle;
  String songName;
  String likes;
  String comments;
  String url;

  VideoPlayerController controller;

  Video(
      {this.id,
      this.user,
      this.userPic,
      this.videoTitle,
      this.songName,
      this.likes,
      this.comments,
      this.url});

  Video.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    user = json['user'];
    userPic = json['user_pic'];
    videoTitle = json['video_title'];
    songName = json['song_name'];
    likes = json['likes'];
    comments = json['comments'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['user_pic'] = this.userPic;
    data['video_title'] = this.videoTitle;
    data['song_name'] = this.songName;
    data['likes'] = this.likes;
    data['comments'] = this.comments;
    data['url'] = this.url;
    return data;
  }

  Future<Null> loadController() async {
    controller = VideoPlayerController.network(url);
    await controller.initialize();
    controller.setLooping(true);
  }
}
