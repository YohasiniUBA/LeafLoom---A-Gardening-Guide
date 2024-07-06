import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void viewDatabase() async {
  // Open the database
  String path = join(await getDatabasesPath(), 'your_database.db');
  Database database = await openDatabase(path);

  // Query the database
  List<Map<String, dynamic>> result = await database.rawQuery('SELECT * FROM your_table');

  // Print the results
  result.forEach((row) {
    print(row);
  });

  // Close the database
  await database.close();
}
