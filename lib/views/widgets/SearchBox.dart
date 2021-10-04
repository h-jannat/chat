import 'package:flutter/material.dart';


class SearchBox extends StatelessWidget {
  SearchBox(this.onSearch);
  final onSearch;
TextEditingController _searchController = TextEditingController(text: "");
  OutlineInputBorder inputBorder = OutlineInputBorder(
    borderSide: const BorderSide(width: 1.0),
    borderRadius: BorderRadius.circular(25.0),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
              //decoration: BoxDecoration(backgroun),
              margin: EdgeInsets.all(20),
              height: 45,
              width: 300,
              alignment: Alignment.center,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: inputBorder,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: ()=>onSearch( _searchController.text),
                  ),
                ),
              ),
            );
  }
}