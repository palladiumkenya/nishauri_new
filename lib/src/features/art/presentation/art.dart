import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:nishauri/src/features/art/model/Facility.dart';

void main() {
//  runApp(ProviderScope(child: Art_Directory());
  ProviderScope(child: Art_Directory());
}

class Art_Directory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // Set the theme to dark
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();
  List<Facility> _facilities = [];
  bool _fetching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facility Directory'),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        // ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Search by name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: _fetching ? null : () {
                    _fetchFacilities(_controller.text);
                  },
                  child: Text('Search'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _facilities.isEmpty && !_fetching
                ? Center(child: Text('No facilities found'))
                : _fetching
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: _facilities.length,
                        itemBuilder: (context, index) {
                          Facility facility = _facilities[index];
                          return ListTile(
                            title: Text(facility.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Telephone: ${facility.telephone}'),
                                Text('County: ${facility.county}'),
                              ],
                              
                            ),
                            
                          );
                          
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchFacilities(String queryParameter) async {
    setState(() {
      _facilities.clear();
      _fetching = true;
    });

    String baseUrl = 'http://prod.kenyahmis.org:8002/api/facility/directory';
    String url = '$baseUrl?name=$queryParameter';

    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body)['message'];
        if (jsonList != null) {
          setState(() {
            _facilities = jsonList.map((json) => Facility.fromJson(json)).toList();
            _fetching = false;
          });
        } else {
          setState(() {
            _fetching = false;
          });
          _showToast('No facilities found');
        }
      } else {
        print('Failed to load facilities. Error: ${response.statusCode}');
        setState(() {
          _fetching = false;
        });
      }
    } catch (e) {
      print('Exception while fetching facilities: $e');
      setState(() {
        _fetching = false;
      });
    }
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}