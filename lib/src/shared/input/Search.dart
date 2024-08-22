import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return  TextField(
      decoration: InputDecoration(
        hintText: "Search ...",
        hintStyle: TextStyle(color: Colors.grey.shade600),
        prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
        filled: true,
        contentPadding: EdgeInsets.all(8),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.grey.shade100
          )
        ),
      ),
    );
  }
}
