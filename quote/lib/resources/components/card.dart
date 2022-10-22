import 'package:flutter/material.dart';
import 'package:quote/resources/color.dart';

class CustomeCard extends StatelessWidget {
  const CustomeCard(
      {Key? key,
      required this.title,
      this.loading = false,
      required this.onPress})
      : super(key: key);
  final String title;
  final bool loading;
  final Function() onPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 100,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
                Radius.circular(10.0)), // Set rounded corner radius
            boxShadow: [
              BoxShadow(
                  blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))
            ] // Make rounded corner of border
            ),
        child: Text(
          "$title",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
