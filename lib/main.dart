import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:thinkly_app/features/notes/data/repositories/note_repository.dart';
import 'package:thinkly_app/features/notes/models/note.dart';
import 'package:thinkly_app/features/notes/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter()); 
  await Hive.openBox<Note>('notes');
//   if (Hive.isBoxOpen('notes')) {
//   await Hive.box<Note>('notes').close();
// }

// await Hive.deleteBoxFromDisk('notes');

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeScreen(),
    );
  }
}
