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
  List<VideoPlayerController> _controllers = [];

   @override
  void initState() {
    super.initState();
    getVideos();
  }

  getVideos() async {
    var videos = await getVideoListForUser('userTest');

    setState(() {
      listVideos = videos;
      listVideos.forEach((element) {
         _controllers.add(getController(element.url));
      });
    }); 
    if(_controllers.length > 0)
      _controllers[0].play();
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
    if(controller != null){
      return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[ 
        GestureDetector(
          onTap: () {
              controller.value.isPlaying
                ? controller.pause()
                : controller.play();
            

          },
          child: controller.value.initialized ?
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
            : CircularProgressIndicator()
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
          SizedBox(height: 65)
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
        BottomToolbar(),
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
}