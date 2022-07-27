import 'package:flutter/material.dart';
import 'db_handler.dart';
import 'add_screen.dart';
import 'note.dart';
import 'detail_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: "testing",
        home: NoteMain()
    );
  }
}
class NoteMain extends StatefulWidget {
  const NoteMain({Key? key}) : super(key: key);

  @override
  State<NoteMain> createState() => _NoteMainState();
}


class _NoteMainState extends State<NoteMain> {
  late DBManage handler;
  @override
  void initState() {
    super.initState();
    handler = DBManage();
    handler.connect();
  }
  final _style = const TextStyle(fontSize: 20,color: Colors.amber);
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Note App",
            style: _style,
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: FutureBuilder(
          future: handler.getNotes(),
          builder:(BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
            return ListView.builder(
              padding: pad,
              itemCount: (snapshot.data == null)?0:snapshot.data?.length,
              itemBuilder: (context, i){
                return ListTile(

                  title: Text(
                    snapshot.data![i].name
                  ),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context)=>DetailScreen(note: snapshot.data![i])
                        )
                    ).then((value) => handler.updateNote(snapshot.data![i]));
                  },
                );
              });
            },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            final value = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=> const AddScreen())
            );
              setState(() {
                if(value != null){
                  handler.insertNote(value);
                }
              }
            );
          },
        ),
      );
    }

}




