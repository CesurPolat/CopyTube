import 'dart:convert';
import 'package:http/http.dart' as http;

var api = "http://3.87.60.121/";
//var api="https://localhost:7232/";

Future<Map> Get(String url) async {
  var resp = await http.get(Uri.parse(api + url));
  //print(resp.body);
  Map<String, dynamic> list = ((jsonDecode(resp
      .body) /* as List*/)) /* .map((e) => e as Map<String,dynamic>).toList() */;
  //print("aaa"+list.runtimeType.toString());
  return list;
}
