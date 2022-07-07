
import 'package:copytube/main.dart' as mainPage;
import 'package:copytube/pages/auth.dart';
import 'package:flutter/material.dart';
import 'package:copytube/core/TokenHelper.dart';

class Account extends StatefulWidget {
  //const Account({ Key? key }) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  var token;
  
  Future<int>? islogin = isLogin();

  @override
  void initState() {
    
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Account"),
        backgroundColor: Color(0xff181818),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
              padding: EdgeInsets.all(15),
              child: FutureBuilder(
                future: islogin,
                builder: (context, AsyncSnapshot snap) {
                  return IndexedStack(
                index: snap.data,
                children: [
                  TextButton(
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_box,
                        ),
                        Text(
                          " Log in!",
                        )
                      ],
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      textStyle: TextStyle(color: Colors.white, fontSize: 24.0),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) => Auth()));
                    },
                  ),
                  TextButton(
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_box,
                        ),
                        Text(
                          " Log out!",
                        )
                      ],
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      textStyle: TextStyle(color: Colors.white, fontSize: 24.0),
                    ),
                    onPressed: () {
                      logout();
                      token = null;
                      Navigator.pop(context);
                      setState(() {});
                    },
                  ),
                ],
              );
                },
              )),
          Expanded(
              child: Align(
            child: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                "Cesur Polat",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            alignment: Alignment.bottomCenter,
          ))
        ],
      ),
      backgroundColor: Color(0xff202020),
    );
  }
}
