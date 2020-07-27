import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/services/database.dart';
import 'package:flutter_chat_app/widgets/widget.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController searchController = new TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot searchSnapshot;

  initiateSearch() {
    databaseMethods.getUserByUserEmail('kyungsnim@kakao.com')
        .then((val) {
          setState(() {
            searchSnapshot = val;
          });
    });
  }

  createChatRoom(String userEmail) {
    List<String> users = [userEmail, userEmail];

//    databaseMethods.createChatRoom(chatRoomId, chatRoomMap)
  }

  Widget searchList() {
    print('searchSnapshot : ${searchSnapshot.documents[0].data['email']}');
    return searchSnapshot != null ? ListView.builder(
      shrinkWrap: true,
      itemCount: searchSnapshot.documents.length,
      itemBuilder: (context, index) {
        return SearchTile(userEmail: searchSnapshot.documents[index].data['email']);
      }
    ) : Container(
      child: Center(
        child: CircularProgressIndicator()
      )
    ) ;
  }

  @override
  void initState() {
    initiateSearch();
    super.initState();
  }
  
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
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.grey,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'search username',
                        hintStyle: TextStyle(
                          color: Colors.white
                        ),
                        border: InputBorder.none
                      ),
                    )
                  ),
                  InkWell(
                    onTap: () {

                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        gradient: LinearGradient(
                          colors: [
                            Colors.white70,
                            Colors.white10
                          ]
                        ),
                      ),
                      height: 40,
                      width: 40,
                      child: Icon(Icons.search, color: Colors.white,)
                    ),
                  ),
                ],
              ),
            ),
            searchList(),
          ],
        )
      )
    );
  }
}

class SearchTile extends StatelessWidget {
  final String userEmail;

  SearchTile({this.userEmail});

  @override
  Widget build(BuildContext context) {
    print('here');
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userEmail),
              Text('5678'),
            ],
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Text('Message'),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16)
          )
        ],
      )
    );
  }
}
