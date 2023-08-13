import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/ui/home/home_page.dart';

class MenuItem2 extends StatefulWidget {
  int index;
   MenuItem2({Key? key, required this.index}) : super(key: key);

  @override
  State<MenuItem2> createState() => _MenuItem2State();
}

class _MenuItem2State extends State<MenuItem2> {
  final controller = Get.find<NoteController>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()  {
        controller.deleteNote(widget.index);
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));

      },
      child: const Row(
        children: [
          Icon(
            Icons.delete,
            color: Colors.black,
          ),
          Padding(
              padding: EdgeInsets.only(left: 10, right: 20),
              child: Text("Delete"))
        ],
      ),
    );
  }
}
