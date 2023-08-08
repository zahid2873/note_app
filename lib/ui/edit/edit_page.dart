import 'package:flutter/material.dart';
import 'package:note_app/model/model_note.dart';

class EditPage extends StatefulWidget {
  ModelNote noteInfo;
  EditPage({Key? key, required this.noteInfo}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edite Note"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.noteInfo.title!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          SizedBox(height: 5,),
          Text(widget.noteInfo.content!),
        ],
      ),
    );
  }
}
