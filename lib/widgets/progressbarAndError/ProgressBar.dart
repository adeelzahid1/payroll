import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            child: CircularProgressIndicator(),
            height: 60,
            width: 60,
          ),
          Text("Please wait..."),
        ],
      ),
    );
  }
}
