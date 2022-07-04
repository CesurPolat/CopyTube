import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

//var api = "http://3.87.60.121/";
var api="https://localhost:7232/";

Future<Map> Get(String url) async {
  var resp = await http.get(Uri.parse(api + url));
  //print(resp.body);
  Map<String, dynamic> list = ((jsonDecode(resp
      .body) /* as List*/)) /* .map((e) => e as Map<String,dynamic>).toList() */;
  //print("aaa"+list["data"][0]["profilePhoto"].toString());
  //print(list["data"][0]["thumbnail"].toString());
  return list;
}

void ViewVideo(){
  
}


//TODO Ayrı dart'a ekle
String TimeAgo(int timestamp){
  int deltaTime=(DateTime.now().millisecondsSinceEpoch~/1000)-timestamp;
  var deltaTimestamp=DateTime.fromMillisecondsSinceEpoch(deltaTime*1000);
  //print(deltaTimestamp.toString());
  if(deltaTimestamp.year-1970>0){
    return deltaTimestamp.year.toString()+" years ago";
  }
  else if(deltaTimestamp.month-1>0){
    return deltaTimestamp.month.toString()+" months ago";
  }
  else if(deltaTimestamp.day-1>0){
    return deltaTimestamp.day.toString()+" days ago";
  }
  else if(deltaTimestamp.hour-2>0){
    return deltaTimestamp.hour.toString()+" hours ago";
  }
  else if(deltaTimestamp.minute>=0){
    return deltaTimestamp.minute.toString()+" minutes ago";
  }
  else /*if(deltaTimestamp.second-1>0)*/{
    return deltaTimestamp.second.toString()+" seconds ago";
  }
}

//TODO Edit here
String isSingle(String timeFormat,int quantity){
  if(quantity%0==0){
    return timeFormat;
  }
  else{
    return timeFormat+"s";
  }
}