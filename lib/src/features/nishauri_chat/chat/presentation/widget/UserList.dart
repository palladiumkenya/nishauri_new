import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/utils/routes.dart';

class UserHCWList extends StatefulWidget {
  String name;
  String messageText;
  String imageURL;
  String time;

  bool isActive;

  UserHCWList({required this.name,required this.messageText,required this.imageURL,required this.time,required this.isActive});
  @override
  _UserHCWListState createState() => _UserHCWListState();
}

class _UserHCWListState extends State<UserHCWList> {
  @override
  Widget build(BuildContext context){
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: (){
        context.goNamed(RouteNames.CHAT_DETAIL);
      },
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage(widget.imageURL),
              maxRadius: 30,
            ),
            SizedBox(width: 16,),
            Expanded(child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.name, style: theme.textTheme.bodyLarge,),
                  SizedBox(height: 6,),
                  Text(widget.messageText, style: theme.textTheme.titleSmall?.merge(TextStyle(color: theme.primaryColorLight)))
                ],
              ),
            )),
            Text(widget.time, style: TextStyle(fontSize: 12,fontWeight: widget.isActive?FontWeight.bold:FontWeight.normal, color: widget.isActive? Colors.green:Colors.grey.shade600),),
          ],
        ),
      ),
    );
  }
}