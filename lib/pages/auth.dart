import 'dart:convert';

import 'package:copytube/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

class Auth extends StatefulWidget {
  //const Auth({ Key? key }) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  int pageIndex=1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: IndexedStack(index: pageIndex,
        children: [
          Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              style: const TextStyle(color: Colors.white),
              controller: email,
              decoration: InputDecoration(
                hintText: "Enter Your E-Mail",
                labelText: "E-Mail",
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
              ),
            ),
            TextFormField(
              style: const TextStyle(color: Colors.white),
              obscureText: true,
              controller: password,
              decoration: InputDecoration(
                hintText: "Enter Your Password",
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  //TODO Crud Ayarlanıcak Ve Bir Library haline getirelecek
                  var resp =await http.post(Uri.parse("http://3.87.60.121/api/Auth/login"),
                      body: jsonEncode({"email": email.text, "password": password.text}),headers: {"Content-Type": 'application/json'});
                  final storage = new FlutterSecureStorage();
                  await storage.write(key: "token", value: resp.body);
                  Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
                },
                child: Text("ds"))
          ],
        ),
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Register",style: TextStyle(color: Colors.white,fontSize: 36.0),textAlign: TextAlign.center,),
              IconButton(onPressed: () async {
                final ImagePicker _picker = ImagePicker();
                final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
              }, icon: CircleAvatar(backgroundColor: Colors.red,),),
              TextButton(onPressed: (){
                pageIndex=0;
                setState(() {});
              }, child: Text("Do You Have Account? Log in!"))
            ]),
        ),
        ],)
      ),
      backgroundColor: Color(0xff202020),
    );
  }
}