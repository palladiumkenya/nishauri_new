import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'pSurvey',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pSurvey'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Tile 1'),
            subtitle: Text('Available Surveys'),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              // Do something when tile 1 is tapped
              print('Tile 1 tapped');
            },
          ),
          ListTile(
            leading: Icon(Icons.photo),
            title: Text('Tile 2'),
            subtitle: Text('Completed Surveys'),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              // Do something when tile 2 is tapped
              print('Tile 2 tapped');
            },
          ),
        ],
      ),
    );
  }
}