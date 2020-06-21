import 'package:flutter/material.dart';

class VideoDescription extends StatelessWidget {

  final username;
  final videtoTitle;
  final songInfo; 

  VideoDescription(this.username,this.videtoTitle,this.songInfo);

  @override
  Widget build(BuildContext context) {
  return Expanded(
    child: Container(
      height: 70.0,
      padding: EdgeInsets.only(left: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[
          Text('@'+username, style: TextStyle(fontWeight: FontWeight.bold),),
          Text(videtoTitle),
          Row(children: [
          Icon(Icons.music_note,  size: 15.0, color: Colors.white,),
          Text(songInfo, style: TextStyle(fontSize: 12.0))]),
        ])
      )
    );
  }
}

