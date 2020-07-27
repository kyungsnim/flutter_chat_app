import 'package:flutter/material.dart';
import 'package:flutter_chat_app/services/auth.dart';
import 'package:flutter_chat_app/signin.dart';
import 'package:flutter_chat_app/widgets/search.dart';
import 'package:flutter_chat_app/widgets/widget.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  AuthMethods authMethods = new AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Free Chatting',
          style: TextStyle(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.w800,
              shadows: [
                Shadow(
                    color: Colors.green,
                    offset: Offset(0.9, 0.9),
                    blurRadius: 0.9
                )
              ]
          ),
        ),
        backgroundColor: Colors.lightGreen,
        actions: [
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => SignIn()
                ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.exit_to_app, color: Colors.white,),
            ),
          )
        ],
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search, color: Colors.white),
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => SearchScreen()
          ));
        },
      ),
    );
  }
}
