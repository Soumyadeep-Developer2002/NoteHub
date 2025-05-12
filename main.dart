import 'package:flutter/material.dart';
import 'package:note_hub/notes_database.dart';
import 'package:note_hub/splash_screen.dart';
import 'package:note_hub/view_model.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(ChangeNotifierProvider(create: (context) => ViewModelProvider(dbObj: NotesDBHelper.setInstance),
  child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
    );
  }
}
