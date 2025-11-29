import 'package:flutter/material.dart';
import 'package:thinkly_app/features/notes/widgets/note_details_card.dart';

class NoteDetails extends StatefulWidget {
  final int noteKey;

  const NoteDetails({super.key, required this.noteKey});

  @override
  State<NoteDetails> createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F5F3),
      body: SafeArea(
        child: SingleChildScrollView(
          child: NoteDetailsCard(noteKey : widget.noteKey),
        ),
      ),
    );
  }
}
