import 'dart:convert';
import 'dart:typed_data';

import 'package:copytube/pages/video_player_Page.dart';
import 'package:flutter/material.dart';
import 'package:copytube/core/HttpHelper.dart';

class Home extends StatefulWidget {
  //const Library({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => __HomeState();
}

class __HomeState extends State<Home> {
  //const ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Future<Map> videoData = Get("api/videos");

    return Container(
        child: FutureBuilder(
      future: videoData,
      builder: (context, AsyncSnapshot snap) {
        //print("in future: "+snap.data.toString());
        if (!snap.hasData) {
            return Center(child: CircularProgressIndicator(color: Colors.white,));

         }
        else{
          //print("build type"+snap.data.runtimeType.toString());
          return RefreshIndicator(child: ListView.builder(
            itemCount: snap.data["data"].length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>VideoPlayerPage(videoId:  snap.data["data"][index]["data"]["videoUrl"].toString(),)));
                },
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,children: [
                  Image.memory(base64Decode(snap.data["data"][index]["data"]["thumbnail"].toString()),fit: BoxFit.fitWidth,scale: 0.1,alignment: Alignment.center,),
                  Row(children: [
                  IconButton(onPressed: () => {}, icon: CircleAvatar(backgroundImage: MemoryImage(base64Decode(snap.data["data"][index]["profilePhoto"].toString())),backgroundColor: Color(0x00),),iconSize: 36.0,),//snap.data["data"][index]["profilePhoto"]
                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    Text(snap.data["data"][index]["data"]["title"],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15.0),textAlign: TextAlign.left,),
                    Text(snap.data["data"][index]["name"]+" • " +snap.data["data"][index]["data"]["view"].toString()+" views • "+ TimeAgo(snap.data["data"][index]["data"]["timestamp"]),style: TextStyle(color: Colors.grey),),
                  ],)
                ],),
                ],),
              );
            }),
            backgroundColor: Colors.black,
            color: Colors.white,
            onRefresh: () async{
              videoData= Future.value(await Get("api/videos"));
              setState((){});
            });
        }
      },
    ));
  }
}
