
import 'package:copytube/core/TokenHelper.dart';
import 'package:copytube/pages/account.dart';
import 'package:copytube/pages/home.dart';
import 'package:copytube/pages/library.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CopyTube',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  //const MyHomePage({Key? key, required this.title}) : super(key: key);

  //final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  final screens = [
    Home(),
    Library(),
    Library(),
  ];


  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.centerLeft,
          height: 25,
          child: SizedBox(
              child: Image.asset(
            'assets/images/logo.png',
          )),
        ), //https://i.hizliresim.com/ihdwqgy.jpg
        actions: [
          IconButton(onPressed: () => {}, icon: Icon(Icons.search)),
          //TODO If ile login
          Center(
            child: IconButton(
                onPressed: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) => Account()))
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
        backgroundColor: Color(0xff181818),
      ),
      body: IndexedStack(index: currentIndex, children: screens),
      backgroundColor: Color(0xff202020),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() => currentIndex = index),
        backgroundColor: Color(0xff181818),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline), label: "Add"),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_library), label: "Library"),
        ],
      ),
    );
  }
}
