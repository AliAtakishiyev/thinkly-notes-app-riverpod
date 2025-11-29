import 'package:hive/hive.dart';
import 'package:thinkly_app/features/notes/models/note.dart';

class NoteRepository {
  final box = Hive.box<Note>('notes');

  List<Note> getAllNotes() {
    return box.values.toList();
  }

  Future<int> addNote(String title, String description, DateTime date) async {
    final note = Note(title: title, description: description, date: date);
    final id = await box.add(note);
    return id;
  }

  Future<void> deleteNote(int hiveId) async {
    await box.delete(hiveId);
  }

  Future<void> editNote(
    String title,
    String description,
    DateTime date,
    final hiveId,
  ) async {
    final note = box.get(hiveId);

    if (note != Null) {
      note!.title = title;
      note.description = description;
      note.date = date;
      note.edittedDate = DateTime.now();
    }

    await box.put(hiveId, note!);
  }
}
