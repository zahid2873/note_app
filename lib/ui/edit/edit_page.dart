import 'package:flutter/material.dart';
import 'package:note_app/model/note_model.dart';

class EditPage extends StatefulWidget {
  NoteModel noteInfo;
  EditPage({Key? key, required this.noteInfo}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.noteInfo.title ??"";
    contentController.text = widget.noteInfo.content ??"";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios_new)),
        actions: [
          DropdownButton(
              icon: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.more_vert,color: Colors.black,),
              ),
              items: [
              //  DropdownMenuItem(child: TextButton(onPressed: (){}, child: Text("Change Color")),)
              ], onChanged: (value){})
        ],
        title: const Text("Edit Note"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                maxLines: 1,
                keyboardType: TextInputType.text,
                onChanged: (value){
                  print(value);
                },
                controller: titleController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*.95-90,
                child: TextField(
                  maxLines: null,
                  minLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  onChanged: (value){
                     print(value);
                  },
                  controller: contentController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  updateInfo(){

  }
}
