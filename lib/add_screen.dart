import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'note.dart';
const pad = EdgeInsets.all(16.0);
class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController controllersName = TextEditingController();
  TextEditingController controllersDesc = TextEditingController();
  late Note newNote;
  var pressed = false;
  Future<bool> _onWillPop() async {
    if(controllersName.text.isEmpty){
      if(pressed) {
        Navigator.pop(context,null);
        return true;
      } else{
        pressed = true;
        Fluttertoast.showToast(
            msg: "Note Name cant be empty, press again to discard",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return false;
      }
    }else{
      newNote = Note(name:controllersName.text, description: controllersDesc.text);
      Navigator.pop(context,newNote);
      return true;
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Note"),
          leading: BackButton(
            onPressed: (){
              if(controllersName.text.isEmpty){
                if(pressed) {
                  Navigator.pop(context,null);
                } else{
                  pressed = true;
                  Fluttertoast.showToast(
                      msg: "Note Name cant be empty, press again to discard",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }
              }else{
                newNote = Note(name:controllersName.text, description: controllersDesc.text);
                Navigator.pop(context,newNote);
              }
            },
          ),
        ),
        body: ListView.builder(
            padding: pad,
            itemCount: 4,
            itemBuilder: (context,index){
              if(index.isOdd) return const Divider();
              final i = index ~/2;
              if (i==0){
                return TextField(
                  maxLines: null,
                  controller: controllersName,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.multiline,
                  autofocus: false,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Note Name"
                  ),
                );
              }
              else{
                return TextField(
                  maxLines: null,
                  controller: controllersDesc,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.multiline,
                  autofocus: false,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Note Description"
                  ),
                );
              }
            }),
      ),
    );
  }
}
