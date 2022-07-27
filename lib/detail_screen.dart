import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'note.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key,required this.note}) : super(key: key);
  final Note note;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  TextEditingController controllers = TextEditingController();
  var pressed = false;
  var changed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.note.name
        ),
      actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: (){
              if(pressed) {
                Navigator.pop(context);
              } else{
                pressed = true;
                Fluttertoast.showToast(
                    msg: "Press again to delete",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }
            },
            tooltip: "Delete Note",
          ),
        ],
        leading: BackButton(
          onPressed: (){
            if(changed){
                Navigator.pop(context,widget.note);
            }else{
              Navigator.pop(context,changed);
            }
          }
        ),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: 4,
          itemBuilder: (context,index){
            controllers.value = TextEditingValue(text: widget.note.description);
            if(index.isOdd){
              return const Divider();
            }
            final i = index ~/2;
            if(i==0){
              return ListTile(

                title: Text(
                  widget.note.name,
                  style: const TextStyle(fontSize: 20),
                ),
              );
            }else{
              return TextField(
                maxLines: null,
                controller: controllers,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.multiline,
                autofocus: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              );
            }

          }
      ),
      floatingActionButton:FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: (){
          changed = true;
          setState(() {
            widget.note.description = controllers.text;
          });
        },
      ),
    );
  }
}