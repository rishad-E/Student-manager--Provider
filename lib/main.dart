import 'package:flutter/material.dart';
import 'package:hive_database/provider/student_provider.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import '../db/model/data_model.dart';
import '../screens/home/screen_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(
      StudentModelAdapter(),
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudentProvider(),
      child: MaterialApp(
        title: 'Student Database',
        theme: ThemeData(
          primaryColor:Colors.green,
        ),
        home: const ScreenHome(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
