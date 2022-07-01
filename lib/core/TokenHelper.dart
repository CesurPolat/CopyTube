import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<int> isLogin() async {
  final storage = new FlutterSecureStorage();
  String? token = await storage.read(key: "token");
  if (token == null) {
    return 0;
  } else {
    return 1;
  }
}

logout(){
  final storage = new FlutterSecureStorage();
  storage.delete(key: "token");
}
