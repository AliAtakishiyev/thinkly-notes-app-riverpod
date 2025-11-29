import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thinkly_app/features/notes/domain/note_notifier.dart';
import 'package:thinkly_app/features/notes/models/note.dart';

final noteProvider = NotifierProvider<NoteNotifier, List<Note>>(
  () => NoteNotifier(),
);