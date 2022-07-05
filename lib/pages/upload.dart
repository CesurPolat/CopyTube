import 'dart:io';

import 'package:copytube/pages/video_player_Page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:copytube/core/HttpHelper.dart';


class Upload extends StatefulWidget {
  //const Upload({ Key? key }) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  XFile? video;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              image =
                  await _picker.pickImage(source: ImageSource.gallery);
              setState(() {
                
              });
            },
            child: Text("Thumbnail"),
          ),
          ElevatedButton(
            onPressed: () async {
              video =
                  await _picker.pickVideo(source: ImageSource.gallery);
              setState(() {
                
              });
              //print(image!.readAsBytes());
              //Navigator.push(context, MaterialPageRoute(builder: (builder)=>VideoPlayerPage(videoId: video!.path.toString())));
            },
            child: Text("Video"),
          ),
          ElevatedButton(
            onPressed: () async {
              //print(image!.name.toString());
              UploadVideo(image!,video!);
            },
            child: Text("Upload"),
          ),
        ],
      ),
    );
  }
}
