import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tiktok_flutter/models/video.dart';
import 'package:tiktok_flutter/screens/home_viewmodel.dart';
import 'package:tiktok_flutter/widgets/actions_toolbar.dart';
import 'package:tiktok_flutter/widgets/bottom_toolbar.dart';
import 'package:tiktok_flutter/widgets/video_description.dart';
import 'package:video_player/video_player.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final homeModel = HomeViewModel();
  @override
  void initState() {
    super.initState();
  }

  Widget get topSection => Container(
        height: 100.0,
        padding: EdgeInsets.only(bottom: 15.0),
        alignment: Alignment(0.0, 1.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Following'),
              Container(
                width: 15.0,
              ),
              Text('For you',
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold))
            ]),
      );

  Widget videoViewer() {
    return Container(
        child: Center(
            child: homeModel.videoList != null
                ? homeModel.videoList.length > 0
                    ? PageView.builder(
                        controller: PageController(
                          initialPage: 0,
                          viewportFraction: 1,
                        ),
                        onPageChanged: (index) {
                          index = index % (homeModel.videoList.length);
                          homeModel.videosManager.changeVideo(index);
                        },
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          index = index % (homeModel.videoList.length);
                          return videoCard(
                              homeModel.videosManager.listVideos[index]);
                        },
                      )
                    : CircularProgressIndicator()
                : CircularProgressIndicator()));
  }

  Widget videoCard(Video video) {
    print(video);
    var controller = video.controller;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        controller != null && controller.value.initialized
            ? GestureDetector(
                onTap: () {
                  controller.value.isPlaying
                      ? controller.pause()
                      : controller.play();
                },
                child: SizedBox.expand(
                    child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: controller.value.size?.width ?? 0,
                    height: controller.value.size?.height ?? 0,
                    child: VideoPlayer(controller),
                  ),
                )))
            : Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  LinearProgressIndicator(),
                  SizedBox(
                    height: 56,
                  )
                ],
              ),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  VideoDescription(
                      video.user, video.videoTitle, video.songName),
                  ActionsToolbar(video.likes, video.comments, video.userPic),
                ],
              ),
              SizedBox(height: 65)
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      disposeViewModel: false,
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: <Widget>[
          videoViewer(),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                topSection,
                BottomToolbar(),
              ],
            ),
          )
        ]),
      ),
      viewModelBuilder: () => homeModel,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
