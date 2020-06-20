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
  List<VideoPlayerController> _controllers;

   @override
  void initState() {
    super.initState();
    getVideos();
  }

  getVideos() async {
    var videos = await getVideoListForUser('userTest');

    setState(() {
      listVideos = videos;
      _controllers = List<VideoPlayerController>(listVideos.length);
      loadVideo(0);      
    }); 
    if(_controllers.length > 0)
      _controllers[0].play();
  }

  loadVideo(index){
    if(_controllers[index] == null){
      setState(() {
        _controllers[index] = getController(listVideos[index].url);
      });
    }
  }

  disposeVideo(index){
    if(index >= 0){
      if(_controllers[index] != null)
        _controllers[index].dispose();
        _controllers[index] = null;
    }
   
  }

  VideoPlayerController getController(url){
      VideoPlayerController controller;
      controller = VideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {
            controller.setLooping(true);
        });
      });
      return controller;
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
      child: listVideos.length > 0 ? PageView.builder(
         controller: PageController(
          initialPage: 0,
          viewportFraction: 1,
        ),
        onPageChanged: (index){
          index = index % (listVideos.length);
          _controllers[prevPage].pause();
          disposeVideo(prevPage-1);
          loadVideo(index);
          _controllers[index].play();
          prevPage = index;
          print(index);

        },
        scrollDirection: Axis.vertical,
        itemBuilder: (context,index){
          index = index % (listVideos.length);
          return videoCard(index);
        },
    )
    : CircularProgressIndicator()   
  ));
  }

  Widget videoCard(index){
    var video = listVideos[index];
    var controller = _controllers[index];
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[ 
        controller != null && controller.value.initialized ? 
        GestureDetector(
          onTap: () {
              controller.value.isPlaying
                ? controller.pause()
                : controller.play();
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
        ) : Column(mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
          LinearProgressIndicator(),
          SizedBox(height: 56,)
        ],),
        Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
                VideoDescription(video.user,video.videoTitle,video.songName),
                ActionsToolbar(video.likes,video.comments,video.userPic),
              ],
          ),
          SizedBox(height: 65)
        ],)
      ],
    );
  }

  Widget get middleSection => Expanded(
    child: videoViewer());

  Widget screenUI(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        topSection,
        BottomToolbar(clearHistory),
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
              ],
            ),
          screenUI()
        ]
      ),
    );
  }

  @override
  void dispose() {
    _controllers.forEach((element) {
      if(element != null){
        element.dispose();
      }
    });
    super.dispose();
  }
}