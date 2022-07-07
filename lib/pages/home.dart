import 'dart:convert';
import 'dart:typed_data';

import 'package:copytube/core/TokenHelper.dart';
import 'package:copytube/pages/account.dart';
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
        child: RefreshIndicator(
      edgeOffset: 56.0,
      onRefresh: () async {
        videoData = Future.value(await Get("api/videos"));
        setState(() {});
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Container(
              alignment: Alignment.centerLeft,
              height: 25,
              child: SizedBox(
                  child: Image.asset(
                'assets/images/logo.png',
              )),
            ),
            actions: [
              IconButton(onPressed: () => {}, icon: Icon(Icons.search)),
              Center(
                child: IconButton(
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => Account()))
                        },
                    icon: FutureBuilder(
                      future: isLogin(),
                      builder: (context, AsyncSnapshot snap) {
                        return IndexedStack(
                          index: snap.data,
                          children: [
                            Icon(Icons.account_circle_outlined),
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://yt3.ggpht.com/yti/APfAmoEeNScZ5fEyOw7apzaChJuGCz3NlnJ30XI1VByx8w=s88-c-k-c0x00ffffff-no-rj-mo"),
                            ),
                          ],
                        );
                      },
                    )),
              )
            ],
            floating: true,
            backgroundColor: Color(0xff181818),
          ),
          FutureBuilder(
            future: videoData,
            builder: (context, AsyncSnapshot snap) {
              if (!snap.hasData) {
                return const SliverFillRemaining(
                  hasScrollBody: true,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  )),
                );
              } else {
                return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => VideoPlayerPage(
                                    videoId: snap.data["data"][index]["data"]
                                            ["videoUrl"]
                                        .toString(),
                                  )));
                    },
                    child: Column(
                      children: [
                        Image.memory(
                          base64Decode(snap.data["data"][index]["data"]
                                  ["thumbnail"]
                              .toString()),
                          fit: BoxFit.cover,
                          height: 220,
                          width: double.infinity,
                          alignment: Alignment.center,
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => {},
                              icon: CircleAvatar(backgroundImage: MemoryImage(base64Decode(snap.data["data"][index]["profilePhoto"].toString())),backgroundColor: Color(0x00),),iconSize: 36.0,), 
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snap.data["data"][index]["data"]["title"],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15.0),textAlign: TextAlign.left,),
                                Text(snap.data["data"][index]["name"] +" • " +snap.data["data"][index]["data"]["view"].toString() +" views • " +TimeAgo(snap.data["data"][index]["data"]["timestamp"]),style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }, childCount: snap.data["data"].length));
              }
            },
          ),
        ],
      ),
    ));
  }
}
