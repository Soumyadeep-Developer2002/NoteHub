import 'package:flutter/material.dart';
import 'package:note_hub/notes_database.dart';
import 'package:note_hub/view_model.dart';
import 'package:provider/provider.dart';

class AddEditNotes extends StatelessWidget {
  bool isUpdated;

  int mSno;
  String mTitle;
  String mDesc;
  AddEditNotes({this.isUpdated = false, this.mSno = 0, this.mTitle = "", this.mDesc = "", });

  // For manually taking user input for their NOTES...
  TextEditingController userTitle = TextEditingController();
  TextEditingController userDesc = TextEditingController();

  void FillFieldsWarning(BuildContext context){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Warning!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.red),),
          content: Text("Please fill all the required fields"),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Ok"))
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    if(isUpdated){
      userTitle.text = mTitle;
      userDesc.text = mDesc;
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.grey.shade900,
        title:RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: "Notes",
                    style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  TextSpan(text: "Control",
                    style: TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold, color: Colors.green))
                ]
              ),
            ),
      ),

      body: Container(
        color: Colors.green.shade50,
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(isUpdated ? "Update Notes here" : "Add Your Notes here", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: TextField(
                    controller: userTitle,
                    decoration: InputDecoration(
                        label: Text("Title"),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                color: Colors.green.shade800,
                                width: 2
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                width: 2
                            )
                        )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: TextField(
                    controller: userDesc,
                    maxLines:10,
                    decoration: InputDecoration(
                        label: Text("Description"),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                color: Colors.green,
                                width: 2
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                width: 2
                            )
                        )
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                      userTitle.clear();
                      userDesc.clear();
                    },
                    style: ElevatedButton.styleFrom(elevation: 10, backgroundColor: Colors.red),
                    child: Icon(Icons.cancel_outlined),
                  ),
          
                  ElevatedButton(
                      onPressed: () async{
                        var mTitle = userTitle.text;
                        var mDesc = userDesc.text;
                        if(mTitle.isNotEmpty && mDesc.isNotEmpty){
                          if(isUpdated){
                            context.read<ViewModelProvider>().updateNotesProvider(mTitle, mDesc, mSno);
                          }else{
                            context.read<ViewModelProvider>().addNotesProvider(mTitle, mDesc);
                          }
                          Navigator.pop(context);
                        } else {
                          FillFieldsWarning(context);
                        }

                      },
                      style: ElevatedButton.styleFrom(elevation: 10, backgroundColor: Colors.green),
                      child:isUpdated ? Icon(Icons.edit) : Icon(Icons.add_circle_outline)
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
