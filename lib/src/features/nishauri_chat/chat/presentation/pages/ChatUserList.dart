import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nishauri/src/features/nishauri_chat/chat/models/chat_hcw.dart';
import 'package:nishauri/src/features/nishauri_chat/chat/presentation/widget/conversationList.dart';
import 'package:nishauri/src/shared/input/Search.dart';
import 'package:nishauri/src/utils/helpers.dart';

class ChatUserListScreen extends StatefulWidget {

  const ChatUserListScreen({Key? key}) : super(key: key);

  @override
  _ChatUserListScreenState createState() => _ChatUserListScreenState();
}

class _ChatUserListScreenState extends State<ChatUserListScreen> {
  List<ChatUsers> chatUsers = [
    ChatUsers(name: "Jane Kamau (Kenyatta Hospital)", messageText: "ART Program", imageURL: "assets/images/chat/userImage1.png", time: "online"),
    ChatUsers(name: "Glady's Murphy (Kenyatta Hospital)", messageText: "Malaria Program", imageURL: "assets/images/chat/userImage2.png", time: "offline"),
    ChatUsers(name: "Jorge Henry (Kenyatta Hospital)", messageText: "TB Program", imageURL: "assets/images/chat/userImage3.png", time: "offline"),
    ChatUsers(name: "Philip Okeyo (Kenyatta Hospital)", messageText: "MCH Program", imageURL: "assets/images/chat/userImage4.png", time: "online"),
    ChatUsers(name: "Debra Joho (Kenyatta Hospital)", messageText: "Some Program", imageURL: "assets/images/chat/userImage5.png", time: "offline"),
  ];
  @override
  Widget build(BuildContext context) {
    final size = getOrientationAwareScreenSize(context);
    final theme = Theme.of(context);
    final searchText = "Search name or program";
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              child: SvgPicture.asset(
                "assets/images/rect-bg.svg",
                semanticsLabel: "Doctors",
                fit: BoxFit.contain,
                height: size.width * 0.55,
                width: size.width * 0.55,
              )
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SafeArea(child: Padding(
                  padding: EdgeInsets.only(left: 16,right: 16,top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      },
                          icon: Icon(Icons.arrow_back, color: Colors.black,)),
                      Text("Select contact", style:theme.textTheme.titleLarge,),
                      // Container(
                      //   padding: EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
                      //   height: 30,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(30),
                      //     color: Colors.pink[50],
                      //   ),
                      //   child: Row(
                      //     children: <Widget>[
                      //       Icon(Icons.search, color: Colors.grey.shade600, size: 20,),
                      //       SizedBox(width: 2,),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                )),
                Padding(
                  padding: EdgeInsets.only(top: 16,left: 16,right: 16),
                  child: Search(searchText: searchText,),
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
        ],
      ),
    );
  }
}