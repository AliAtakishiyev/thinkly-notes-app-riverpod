import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:thinkly_app/features/notes/providers/note_provider.dart';
import 'package:thinkly_app/features/notes/screens/note_details.dart';

class Notes extends ConsumerWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use ref here
    final notes = ref.watch(noteProvider);

    return Expanded(
      child: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];

          final day = note.date?.day;
          final month = note.date == null
              ? null
              : DateFormat('MMM').format(note.date!);
          final year = note.date?.year;
          final hour = (note.date!.hour == 0)
              ? 12
              : (note.date!.hour > 12)
              ? note.date!.hour - 12
              : note.date!.hour;
          final minute = note.date?.minute;
          final amPm = note.date != Null
              ? DateFormat('a').format(note.date!)
              : Null;
          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: SizedBox(
              height: 180,
              child: InkWell(
                onTap: () {
                  final noteKey = note.key as int?; // Get the Hive key
                  if (noteKey != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NoteDetails(noteKey: noteKey), // ← Pass key
                      ),
                    );
                  }
                },
                child: Card(
                  elevation: 3,
                  color: Color(0xffFDFDFD),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${note.title}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),

                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${note.description}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff666E7E),
                          ),

                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "$month $day, $year at $hour:$minute $amPm",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff666E7E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
