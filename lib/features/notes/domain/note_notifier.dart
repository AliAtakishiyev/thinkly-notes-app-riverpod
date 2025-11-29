import 'package:riverpod/riverpod.dart';
import 'package:thinkly_app/features/notes/data/repositories/note_repository.dart';
import 'package:thinkly_app/features/notes/models/note.dart';

class NoteNotifier extends Notifier<List<Note>> {
  late final NoteRepository repository;

  @override
  List<Note> build() {
    repository = NoteRepository();
    return repository.getAllNotes();
  }

  Future<void> addNote(String title, String description, DateTime date) async {
    await repository.addNote(title, description, date);
    state = repository.getAllNotes();
  }

  Future<void> editNote(
    String title,
    String description,
    DateTime date,
    final hiveId,
  ) async {
    await repository.editNote(title, description, date, hiveId);
    state = repository.getAllNotes();
  }

  Future<void> deleteNote(int hiveId) async {
    await repository.deleteNote(hiveId);
    state = repository.getAllNotes();
  }

  void refresh() {
    state = repository.getAllNotes();
  }
}
