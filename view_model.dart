import 'package:flutter/cupertino.dart';
import 'package:note_hub/notes_database.dart';

class ViewModelProvider extends ChangeNotifier{
  NotesDBHelper dbObj; // Here we need database...
  ViewModelProvider({required this.dbObj}); // No need to call repeatedly...
  List<Map<String, dynamic>> _realData = [];

  // Here we cal Events...

  //Adding the notes...
  void addNotesProvider(String mTitle, String mDesc) async{
   bool check = await dbObj.insertALlNotes(myTitle: mTitle, myDesc: mDesc);
   if(check) {
     _realData = await dbObj.readAllNotes();
     notifyListeners();
   }
  }

  // Updating the notes...
  void updateNotesProvider(String mTitle, String mDesc, int mSno) async{
    bool check = await dbObj.updateNotes(mTitle: mTitle, mDesc: mDesc, mSno: mSno);
    if(check){
      _realData = await dbObj.readAllNotes();
      notifyListeners();
    }
  }

  List<Map<String, dynamic>> getUserNotesProvider() => _realData;

  void getNotesFirst() async{
    _realData = await dbObj.readAllNotes();
    notifyListeners();
  }

  void delNotesProvider(int sno) async{
    bool check = await dbObj.deletedNotes(mSno: sno);
    if(check){
      _realData = await dbObj.readAllNotes();
      notifyListeners();
    }
  }
}