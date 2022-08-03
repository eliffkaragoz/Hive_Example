import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:untitled/ui/view/authentication/login_view.dart';
import 'package:hive_flutter/hive_flutter.dart';


Future<void> main() async{
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: LoginView()
    );
  }
}

