import 'package:flutter/material.dart';

class MenuItem1 extends StatefulWidget {
  const MenuItem1({Key? key}) : super(key: key);

  @override
  State<MenuItem1> createState() => _MenuItem1State();
}

class _MenuItem1State extends State<MenuItem1> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showInputDialog();
      },
      child:  Row(
        children: [
          Icon(
            Icons.color_lens,
            color: Colors.black,
          ),
          Padding(
              padding: EdgeInsets.only(left: 10, right: 20),
              child: Text("Color"))
        ],
      ),
    );
  }

  showInputDialog() {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text("Color"),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            InkWell(
              child: CircleAvatar(

                backgroundColor: Color.fromRGBO(255, 191, 208, 1),
               // child: IconButton(onPressed: (){}, icon: icon)
              ),
            ),
            SizedBox(
              width: 5,
            ),
            CircleAvatar(
              backgroundColor: Color.fromRGBO(192, 229, 255, 1),
              child: Icon(Icons.check,color: Colors.black,),
            ),
            SizedBox(
              width: 5,
            ),
            CircleAvatar(
              backgroundColor: Color.fromRGBO(191, 255, 231, 1),
              child: Icon(Icons.check,color: Colors.black,),
            ),
            SizedBox(
              width: 5,
            ),
            CircleAvatar(
              backgroundColor: Color.fromRGBO(255, 242, 190, 1),
              child: Icon(Icons.check,color: Colors.black,),
            ),
          ],
        ),
        actions: [],
      ),
    );
  }

  showModal(){
    showModalBottomSheet(context: context, builder: (context){
      return Container();
    });
  }

}
