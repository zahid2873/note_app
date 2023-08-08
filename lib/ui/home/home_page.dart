import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/ui/edit/edit_page.dart';
import 'package:note_app/ui/home/note_widget.dart';
import 'package:note_app/model/model_note.dart';

class HomePage extends StatefulWidget {
   const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Recent Notes"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: MasonryGridView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: noteList.length,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
            ),
          itemBuilder: (context,index){
            return NoteWidget(noteInfo: noteList[index]);
          },
        ),
      ),
    );
  }
}
