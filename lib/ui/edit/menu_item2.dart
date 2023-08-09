import 'package:flutter/material.dart';

class MenuItem2 extends StatelessWidget {
  const MenuItem2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          Icons.delete,
          color: Colors.black,
        ),
        Padding(
            padding: EdgeInsets.only(left: 10, right: 20),
            child: Text("Delete"))
      ],
    );
  }
}
