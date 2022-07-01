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
              return Column(crossAxisAlignment: CrossAxisAlignment.stretch,children: [
                Image.network("https://i.ytimg.com/vi/8jLhoEjaqoQ/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCqjFrn0F--IfJEbRiJAHGcT04DBQ",fit: BoxFit.fitWidth,scale: 0.1,alignment: Alignment.center,),
                Row(children: [
                IconButton(onPressed: () => {}, icon: CircleAvatar(backgroundImage: NetworkImage("https://yt3.ggpht.com/yti/APfAmoEeNScZ5fEyOw7apzaChJuGCz3NlnJ30XI1VByx8w=s88-c-k-c0x00ffffff-no-rj-mo"),),iconSize: 36.0,),
                Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Text(snap.data["data"][index]["video"]["title"],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15.0),textAlign: TextAlign.left,),
                  Text(snap.data["data"][index]["name"]+" • " +snap.data["data"][index]["video"]["view"].toString()+" views • "+"Tarih",style: TextStyle(color: Colors.grey),),
                ],)
              ],),
              ],);
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
