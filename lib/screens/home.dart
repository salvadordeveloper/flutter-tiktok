import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_flutter/models/video.dart';
import 'package:tiktok_flutter/widgets/actions_toolbar.dart';
import 'package:tiktok_flutter/widgets/bottom_toolbar.dart';
import 'package:tiktok_flutter/widgets/video_description.dart';
import 'package:video_player/video_player.dart';
import 'package:tiktok_flutter/data/firebaseData.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  var listVideos= <Video>[];
  var prevPage = 0;

   @override
  void initState() {
    super.initState();
    getVideos();
  }

  getVideos() async {
    var videos = await getVideoList();
    videos.forEach((element) => element.setupVideo());

    setState(() {
      listVideos = videos;
    });

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
                style: TextStyle(
                    fontSize: 17.0, fontWeight: FontWeight.bold))
          ]),
    );

  Widget videoViewer(){
    return Container(
     child: Center(
      child: listVideos.length > 0 ? CarouselSlider.builder(
        options: CarouselOptions(
        autoPlay: false,
        height: MediaQuery.of(context).size.height,
        enlargeCenterPage: false,
        viewportFraction: 1.0,
        initialPage: 0,
        scrollDirection: Axis.vertical,

        onPageChanged: (index, reason) {
            setState(() {
              listVideos[prevPage].controller.pause();
              listVideos[index].controller.play();
              prevPage = index;
            });
        },

      ),
      itemCount: listVideos.length,
      itemBuilder: (BuildContext context, int itemIndex) => videoCard(itemIndex)
        
    ) : CircularProgressIndicator()   
  ));
  }

  Widget videoCard(item){
    var video = listVideos[item];
    var controller = video.controller;
    if(controller != null){
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[ 
        GestureDetector(
          onTap: () {
            setState(() {
              controller.value.isPlaying
                ? controller.pause()
                : controller.play();
            });
          },
          child: 
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: controller.value.size?.width ?? 0,
                  height: controller.value.size?.height ?? 0,
                  child: VideoPlayer(controller),
                ),
              )
            )
        ),
        Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
                VideoDescription(video.user,video.videoTitle,video.songName),
                ActionsToolbar(video.likes,video.comments,video.userPic),
              ],
          ),
          SizedBox(height: 10,)
        ],)
      ],
    );
    }
    return CircularProgressIndicator();
  }

  Widget get middleSection => Expanded(
    child: videoViewer());

  Widget screenUI(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        topSection,
      ],
    );
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: 
        Stack(children: <Widget>[
            Column(
              children: <Widget>[
                middleSection,
                BottomToolbar(),
              ],
            ),
          screenUI()
        ]
      ),
    );
  }
}