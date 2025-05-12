import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NotesDBHelper{
  NotesDBHelper._();
  static final NotesDBHelper setInstance = NotesDBHelper._(); // Make it Singleton...
  Database? myDatabase;

  // Make custom table notes name...
  static final String TABLE_NOTES = "notes";
  static final String NOTES_ID = "s_no";
  static final String NOTES_TITLE = "title";
  static final String NOTES_DESCRIPTION = "description";

  // Get the Database...
  Future<Database> getDatabase() async{
    myDatabase ??= await setDatabase();  // Get the data if exist or call the setDatabase()...
    return myDatabase!;
  }

  // Database creation...
  Future<Database> setDatabase() async{
    Directory appDir = await getApplicationDocumentsDirectory(); // Get the path...
    String databasePath = join(appDir.path, "NotesData.db"); // Join that path with Database file...

    return openDatabase(databasePath, onCreate: (db, version){  // Create a Database here ...
      db.execute('''
      create table $TABLE_NOTES (
      $NOTES_ID integer primary key autoincrement,
      $NOTES_TITLE text,
      $NOTES_DESCRIPTION text)
      ''');

    }, version: 1);
  }

  // Notes add here...
  Future<bool> insertALlNotes({required String myTitle, required String myDesc}) async{
    var db = await getDatabase();

    int effectedRows = await db.insert(TABLE_NOTES,{
      NOTES_TITLE : myTitle,
      NOTES_DESCRIPTION : myDesc
    });

    return effectedRows > 0;
  }

  // Fetching all notes from here...
  Future<List<Map<String, dynamic>>> readAllNotes() async{
    var db = await getDatabase();
    
    List<Map<String, dynamic>> myData = await db.query(TABLE_NOTES);  // That means (Select * from table)
    return myData;
  }

  // Update all of your notes here...
  Future<bool> updateNotes({required String mTitle, required String mDesc, required int mSno}) async{
    var db = await getDatabase();

    int rowsEffected = await db.update(TABLE_NOTES, {   // Uniquely Notes updated...
      NOTES_ID: mTitle,
      NOTES_DESCRIPTION: mDesc,
      NOTES_ID: mSno
    },where: "$NOTES_ID = ?", whereArgs: ['$mSno']);

    return rowsEffected > 0;
  }

  Future<bool> deletedNotes({required int mSno}) async{
    var db = await getDatabase();

    int rowsEffected = await db.delete(TABLE_NOTES, where: "$NOTES_ID = ?", whereArgs: ['$mSno']);

    return rowsEffected > 0;
  }
}