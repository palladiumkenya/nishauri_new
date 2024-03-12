import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  //runApp(Art_Directory());
   ProviderScope(child: Art_Directory());
}

class Art_Directory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ART'),
        ),
        body: Column(
          children: [
            // Horizontal row containing TextField and Button
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter Facility Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Button onPressed action
                  },
                  child: Text('Button'),
                ),
              ],
            ),
            // Vertical ListView
            Expanded(
              child: ListView.builder(
                itemCount: 20, // Example item count
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
