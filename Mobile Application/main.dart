import 'package:flutter/material.dart';
import 'package:leaf_loom/database_helper.dart';
import 'package:leaf_loom/login_page.dart'; // Import LoginPage class

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LeafLoom',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(), // Set LoginPage as the home
    );
  }
}
