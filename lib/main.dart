import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_portal/data/database_helper.dart';
import 'package:news_portal/res/color.dart';
import 'package:news_portal/utils/routes/routes.dart';
import 'package:news_portal/utils/routes/routes_name.dart';

//import 'package:path/path.dart';
//import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Code for sqflite data

  // Path to the database file
  // String path = join(await getDatabasesPath(), 'app_database.db');

  // Open the database
  // Database database = await openDatabase(path);

  // Query all rows from the 'users' table
  //List<Map<String, dynamic>> users = await database.query('users');

  // Print the results
  // users.forEach((user) {
  //  print('User: $user');
//  });

  // Close the database
  // await database.close();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.bgColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  final DatabaseHelper databaseHelper = DatabaseHelper();
  databaseHelper.initDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.bgColor),
        useMaterial3: true,
      ),
      initialRoute: RoutesName.splashscreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
