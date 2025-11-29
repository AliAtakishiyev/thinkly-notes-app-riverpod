import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thinkly_app/features/notes/providers/note_provider.dart';

class CreateNoteDialog extends ConsumerStatefulWidget {
  const CreateNoteDialog({super.key});

  @override
  ConsumerState<CreateNoteDialog> createState() => _CreateNoteDialogState();
}

class _CreateNoteDialogState extends ConsumerState<CreateNoteDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(),

      child: Container(
        width: double.infinity,
        color: Color(0xffFDFDFD),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      if (mounted) {
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(Icons.close, size: 20),
                  ),
                ],
              ),

              Text(
                "New Note",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 32),
              ),

              SizedBox(height: 36),

              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffF7F5F3),
                  hint: Text(
                    "Give your note a title...",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                      color: Color(0xff666E7E),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffE6E1DC)),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xff2A7DED), width: 3),
                  ),
                ),
              ),

              SizedBox(height: 24),

              TextField(
                controller: descriptionController,
                maxLines: 10,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffF7F5F3),
                  hint: Text(
                    "What's in your mind?",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Color(0xff666E7E),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffE6E1DC)),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xff2A7DED), width: 3),
                  ),
                ),
              ),

              SizedBox(height: 48),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 120,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (mounted) {
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffF0EDE4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),

                  SizedBox(width: 12),

                  SizedBox(
                    width: 120,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        String title = titleController.text.trim();
                        String description = descriptionController.text.trim();
                        final now = DateTime.now();

                        if (title.isNotEmpty) {
                          await ref
                              .read(noteProvider.notifier)
                              .addNote(title, description, now);
                          if (mounted) {
                            Navigator.pop(context);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff2679E8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Create",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
