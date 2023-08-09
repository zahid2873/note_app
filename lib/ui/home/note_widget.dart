import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:note_app/constant/color_palette.dart';
import 'package:note_app/model/note_model.dart';



class NoteWidget extends StatefulWidget {
  Callback onTap;
   NoteModel noteInfo;
   NoteWidget({Key? key,required this.noteInfo, required this.onTap}) : super(key: key);

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  ColorPalette  color = ColorPalette();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: widget.noteInfo.color,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.noteInfo.title==null ? const SizedBox() :
            Text(widget.noteInfo.title!,
              style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5,),
            Text(widget.noteInfo.content ?? "",
              softWrap: false,
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
      ),
    );
  }



}
   