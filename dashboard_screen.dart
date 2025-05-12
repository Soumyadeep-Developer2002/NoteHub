import 'package:flutter/material.dart';
import 'package:note_hub/add_edit_notes.dart';
import 'package:note_hub/notes_database.dart';
import 'package:note_hub/view_model.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  NotesDBHelper? dbObj;

  @override
  void initState() {
    // When opening the app, first make sure that the notes are shown to you.
    super.initState();
    context.read<ViewModelProvider>().getNotesFirst();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: RichText(
          text: TextSpan(
              children: [
                TextSpan(text: "Note",
                    style: TextStyle(fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                TextSpan(text: "Hub",
                    style: TextStyle(fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70))
              ]
          ),
        ),
      ),


      body: Consumer<ViewModelProvider>(
        builder: (context01, provider, __){
          List<Map<String, dynamic>> notesHere = provider.getUserNotesProvider();
          return Container(
            child: notesHere.isNotEmpty ? ListView.builder(
              itemCount: notesHere.length,
              itemBuilder: (_, index) {
                return Card(
                  color: Colors.green.shade50,
                  shadowColor: Colors.black,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                      side: BorderSide(
                        color: Colors.black,
                        width: 1,
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      leading: Text(
                        '${index + 1}'),
                        title: Text(notesHere[index][NotesDBHelper.NOTES_TITLE]),
                        subtitle: Text(
                          notesHere[index][NotesDBHelper.NOTES_DESCRIPTION]),
                          trailing: SizedBox(
                            width: 20,
                            child: PopupMenuButton(
                              color: Colors.blue.shade50,
                              onSelected: (value) async{
                                if(value == 'edit'){
                                  Navigator.push(
                                    context, MaterialPageRoute(
                                      builder: (context) => AddEditNotes(
                                        isUpdated: true,
                                        mSno: notesHere[index][NotesDBHelper.NOTES_ID],
                                        mTitle: notesHere[index][NotesDBHelper.NOTES_TITLE],
                                        mDesc: notesHere[index][NotesDBHelper.NOTES_DESCRIPTION],
                                      )
                                    )
                                  );
                                } else if (value == 'del'){
                                  int sno = notesHere[index][NotesDBHelper.NOTES_ID];
                                 context01.read<ViewModelProvider>().delNotesProvider(sno);
                                }
                              },
                              itemBuilder: (context){
                                return[
                                  PopupMenuItem(value: 'edit', child: Text("Edit", style: TextStyle(color: Colors.green.shade700, fontSize: 17, fontWeight: FontWeight.bold),)),
                                  PopupMenuItem(value: 'del', child: Text("Delete", style: TextStyle(color: Colors.red, fontSize: 17, fontWeight: FontWeight.bold),))
                                ];
                              }),
                          ),
                    ),
                  ),
                );
              }) : Center(child: Text("No Notes yet!"),),
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditNotes()));
          },
        backgroundColor: Colors.teal.shade300,
        child: Icon(Icons.add),),
    );
  }
}


