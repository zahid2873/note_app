import 'package:flutter/material.dart';

class MenuItem1 extends StatefulWidget {
  const MenuItem1({Key? key}) : super(key: key);

  @override
  State<MenuItem1> createState() => _MenuItem1State();
}

class _MenuItem1State extends State<MenuItem1> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          Icons.color_lens,
          color: Colors.black,
        ),
        Padding(
            padding: EdgeInsets.only(left: 10, right: 20),
            child: Text("Color"))
      ],
    );
  }
}
