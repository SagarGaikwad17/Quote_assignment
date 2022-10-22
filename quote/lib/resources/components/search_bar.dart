import 'package:flutter/material.dart';
import 'package:quote/resources/color.dart';

class SearchBar extends StatelessWidget {
  const SearchBar(
      {Key? key,
      required this.title,
      this.loading = false,
      required this.onPress})
      : super(key: key);
  final String title;
  final bool loading;
  final Function(String) onPress;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 8, left: 8, right: 8),
      child: TextField(
        onChanged: onPress,
        decoration: InputDecoration(
          hintText: title,
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(7.0)),
          ),
        ),
      ),
    );
  }
}
