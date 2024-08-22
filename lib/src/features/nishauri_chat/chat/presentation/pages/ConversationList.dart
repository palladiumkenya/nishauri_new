import 'package:flutter/material.dart';
import 'package:nishauri/src/features/nishauri_chat/chat/models/chat_hcw.dart';
import 'package:nishauri/src/features/nishauri_chat/chat/presentation/widget/conversationList.dart';
import 'package:nishauri/src/shared/input/Search.dart';

class ChatHCWScreen extends StatefulWidget {

  const ChatHCWScreen({Key? key}) : super(key: key);

  @override
  _ChatHCWScreenState createState() => _ChatHCWScreenState();
}

class _ChatHCWScreenState extends State<ChatHCWScreen> {
  List<ChatUsers> chatUsers = [
    ChatUsers(name: "Jane Russel", messageText: "Awesome Setup", imageURL: "assets/images/chat/userImage1.png", time: "Now"),
    ChatUsers(name: "Glady's Murphy", messageText: "That's Great", imageURL: "assets/images/chat/userImage2.png", time: "Yesterday"),
    ChatUsers(name: "Jorge Henry", messageText: "Hey where are you?", imageURL: "assets/images/chat/userImage3.png", time: "31 Mar"),
    ChatUsers(name: "Philip Fox", messageText: "Busy! Call me in 20 mins", imageURL: "assets/images/chat/userImage4.png", time: "28 Mar"),
    ChatUsers(name: "Debra Hawkins", messageText: "Thankyou, It's awesome", imageURL: "assets/images/chat/userImage5.png", time: "23 Mar"),
    ChatUsers(name: "Jacob Pena", messageText: "will update you in evening", imageURL: "assets/images/chat/userImage6.png", time: "17 Mar"),
    ChatUsers(name: "Andrey Jones", messageText: "Can you please share the file?", imageURL: "assets/images/chat/userImage7.png", time: "24 Feb"),
    ChatUsers(name: "John Wick", messageText: "How are you?", imageURL: "assets/images/chat/userImage8.png", time: "18 Feb"),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(child: Padding(
              padding: EdgeInsets.only(left: 16,right: 16,top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Chat List", style:theme.textTheme.titleLarge,),
                  Container(
                    padding: EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.pink[50],
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.add, color: Colors.pink, size: 20,),
                        SizedBox(width: 2,),
                        Text("Add New", style: theme.textTheme.titleMedium,),
                      ],
                    ),
                  )
                ],
              ),
            )),
            Padding(
              padding: EdgeInsets.only(top: 16,left: 16,right: 16),
              child: Search(),
            ),
          ListView.builder(
            itemCount: chatUsers.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 16),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              return ConversationList(
                name: chatUsers[index].name,
                messageText: chatUsers[index].messageText,
                imageURL: chatUsers[index].imageURL,
                time: chatUsers[index].time,
                isMessageRead: (index == 0 || index == 3) ? true:false,
              );
            }
          )
          ],
        ),
      ),
    );
  }
}