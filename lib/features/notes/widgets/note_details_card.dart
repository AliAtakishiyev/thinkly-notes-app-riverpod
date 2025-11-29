import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thinkly_app/features/notes/providers/note_provider.dart';
import 'package:thinkly_app/features/notes/widgets/edit_note_dialog.dart';

class NoteDetailsCard extends ConsumerStatefulWidget {
  // ← Changed
  final int noteKey; // ← KEEP THIS EXACTLY AS IS!

  const NoteDetailsCard({super.key, required this.noteKey});

  @override
  ConsumerState<NoteDetailsCard> createState() => _NoteDetailsCardState(); // ← Changed
}

class _NoteDetailsCardState extends ConsumerState<NoteDetailsCard> {
  @override
  Widget build(BuildContext context) {
    // Watch the provider to get all notes
    final notes = ref.watch(noteProvider);

    // Find the note by its key
    final note = notes.firstWhereOrNull((n) => n.key == widget.noteKey);

    // If note is deleted, just go back silently
    if (note == null) {
      Future.microtask(() {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      });
      return const SizedBox.shrink(); // show nothing while exiting
    }

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
    final amPm = note.date != null ? DateFormat('a').format(note.date!) : null;

    final dayE = note.edittedDate?.day;
    final monthE = note.edittedDate == null
        ? null
        : DateFormat('MMM').format(note.edittedDate!);
    final yearE = note.edittedDate?.year;
    final hourE = (note.edittedDate == null)
        ? null
        : (note.edittedDate!.hour == 0)
        ? 12
        : (note.edittedDate!.hour > 12)
        ? note.edittedDate!.hour - 12
        : note.edittedDate!.hour;

    final minuteE = note.edittedDate?.minute;
    final amPmE = note.edittedDate != null
        ? DateFormat('a').format(note.edittedDate!)
        : null;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            height: 50,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [Icon(Icons.arrow_back_ios), Text("Back")],
              ),
              style: IconButton.styleFrom(
                backgroundColor: Color(0xffF0EDE4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
              ),
            ),
          ),

          SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(24),
              ),
              color: Color(0xffFCFDFD),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        PopupMenuButton<String>(
                          icon: Icon(Icons.more_vert),
                          color: Colors.white,
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(minWidth: 250),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black, width: 0.2),
                            borderRadius: BorderRadiusGeometry.circular(12),
                          ),
                          offset: Offset(-10, 44),
                          onSelected: (value) async {
                            if (value == 'delete') {
                              //await _handleDelete(widget.note.key, context);
                              final hiveId = note.key;

                              if (hiveId == null) return;

                              final shouldDelete = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: Colors.white,
                                  insetPadding: EdgeInsets.zero,
                                  title: Text(
                                    "Are you sure?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      0,
                                    ),
                                  ),
                                  content: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      "This action cannot be undone. This will permanetly delete your note.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  actions: [
                                    Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            height: 50,
                                            child: ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, true),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(
                                                  0xffE74D4C,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadiusGeometry.circular(
                                                        12,
                                                      ),
                                                ),
                                              ),

                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),

                                          SizedBox(height: 12),
                                          SizedBox(
                                            width: double.infinity,
                                            height: 50,
                                            child: ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, false),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                side: BorderSide(
                                                  color: Colors.black,
                                                  width: 0.3,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadiusGeometry.circular(
                                                        12,
                                                      ),
                                                ),
                                              ),
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );

                              if (shouldDelete == true && mounted) {
                                await ref
                                    .read(noteProvider.notifier)
                                    .deleteNote(hiveId);
                                if (mounted) {
                                  Navigator.pop(context);
                                }
                              }
                            } else if (value == 'edit') {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return EditNoteDialog(note: note);
                                },
                              );
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'edit',
                              height: 40,
                              child: Row(
                                children: [
                                  Icon(Icons.edit_outlined),
                                  SizedBox(width: 10),
                                  Text('Edit Note'),
                                ],
                              ),
                            ),

                            PopupMenuDivider(),
                            PopupMenuItem(
                              value: 'delete',
                              height: 40,
                              child: Row(
                                children: [
                                  Icon(Icons.delete_outline, color: Colors.red),
                                  SizedBox(width: 10),
                                  Text('Delete Note'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Text(
                      "${note.title}",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 32,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 20,
                        top: 20,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 4,
                            ),
                          ),
                          Text(
                            "Created : $month $day, $year at $hour:$minute $amPm",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 30,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: CircleAvatar(
                              backgroundColor: Colors.orange,
                              radius: 4,
                            ),
                          ),
                          Text(
                            (note.edittedDate == null)
                                ? "Updated : $month $day, $year at $hour:$minute $amPm"
                                : "Updated : $monthE $dayE, $yearE at $hourE:$minuteE $amPmE",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),

                    if (note.description!.isEmpty)
                      SizedBox(height: 24)
                    else ...[
                      Container(height: 1, color: Color(0xffE6E1DC)),
                      SizedBox(height: 30),

                      Text(
                        "${note.description}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
