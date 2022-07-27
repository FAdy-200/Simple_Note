import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'note.dart';
class DBManage{
  Future<Database> connect() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      join(await getDatabasesPath(), 'notes.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT)',
        );
      },
      version: 1,
    );
  }
  Future<List<Note>> getNotes() async{
    final db = await connect();
    final List<Map<String, Object?>> queryResult = await db.query('notes');
    return queryResult.map((e) => Note.fromMap(e)).toList();
  }

  Future<void> insertNote(Note note) async {
    final db = await connect();
    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<void> updateNote(Note note) async{
    final db = await connect();
    db.update('notes', note.toMap(), where: 'id = ?',whereArgs: [note.id]);
  }
  Future<void> deleteNote(Note note) async {
    final db = await connect();
    db.delete('notes', where: "id = ?", whereArgs: [note.id]);
  }
}