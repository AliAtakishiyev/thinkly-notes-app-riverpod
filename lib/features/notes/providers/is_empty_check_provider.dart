import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thinkly_app/features/notes/data/repositories/note_repository.dart';
import 'package:thinkly_app/features/notes/providers/note_provider.dart';

final isEmptyCheckProvider = FutureProvider<bool>((ref){
  final notes = ref.watch(noteProvider);
  return notes.isEmpty;
});