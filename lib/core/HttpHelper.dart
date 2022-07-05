import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

var api = "http://3.87.60.121/";
//var api="https://localhost:7232/";

Future<Map> Get(String url) async {
  var resp = await http.get(Uri.parse(api + url));
  //print(resp.body);
  Map<String, dynamic> list = ((jsonDecode(resp
      .body) /* as List*/)) /* .map((e) => e as Map<String,dynamic>).toList() */;
  //print("aaa"+list["data"][0]["profilePhoto"].toString());
  //print(list["data"][0]["thumbnail"].toString());
  return list;
}

Future UploadVideo(XFile thumbnail,XFile video) async {
  var resp = await http.MultipartRequest("POST",Uri.parse(api+"api/Videos"));
  resp.fields["Title"]="Test From Flutter";
  resp.fields["Description"]="Test Desc From Flutter";
  resp.files.add(http.MultipartFile.fromBytes('thumbnail', List.from(await thumbnail.readAsBytes()),filename: thumbnail.name));
  resp.files.add(http.MultipartFile.fromBytes('video', List.from(await video.readAsBytes()),filename: video.name));
  resp.headers["Content-type"]="multipart/form-data";
  resp.headers["Authorization"]="Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjEiLCJuYmYiOjE2NTcwMTkzMjksImV4cCI6MTY1NzEwNTcyOSwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdC8iLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0LyJ9.frpeRHA7G16DvibDldmKJEYoVcmLm4Eb--B8iHWIa3g";
  resp.send().then((value) => print("Http"+value.toString()));
  /*,headers: {'Content-type': 'multipart/form-data','Authorization':'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjEiLCJuYmYiOjE2NTcwMTkzMjksImV4cCI6MTY1NzEwNTcyOSwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdC8iLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0LyJ9.frpeRHA7G16DvibDldmKJEYoVcmLm4Eb--B8iHWIa3g'},
  body: jsonEncode({
    "Title":"Test From Flutter",
    "Description":"Test Desc From Flutter",
    "thumbnail":[thumbnail],
    "video":[video]
  }));*/
  //print(resp.body);
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