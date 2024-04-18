import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project_week8/database/datamodel.dart';
import 'package:project_week8/screens/splash.dart';


const SAVE_KEY_NAME='userLoggedIn';
Future<void> main()async{
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(SignUpModelAdapter().typeId)){
    Hive.registerAdapter(SignUpModelAdapter());
  }
   if(!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)){
    Hive.registerAdapter(CategoryModelAdapter());
  }
   if(!Hive.isAdapterRegistered(BookModelAdapter().typeId)){
    Hive.registerAdapter(BookModelAdapter());
  }
  runApp(Myapp());
}




class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:ScreenSplash(),
    );
}
}