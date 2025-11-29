import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thinkly_app/features/notes/providers/is_empty_check_provider.dart';
import 'package:thinkly_app/features/notes/widgets/create_note_dialog.dart';
import 'package:thinkly_app/features/notes/widgets/custom_app_bar.dart';
import 'package:thinkly_app/features/notes/widgets/no_notes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thinkly_app/features/notes/widgets/notes.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final isEmpty = ref.watch(isEmptyCheckProvider);
    return Scaffold(
      backgroundColor: Color(0xffF7F5F3),

      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(),
            //Spacer(flex: 2),
            (isEmpty.asData?.value == true)
                ? Spacer(flex: 2)
                : SizedBox(height: 36),
            isEmpty.when(
              data: (isEmpty) => isEmpty ? NoNotes() : Notes(),
              loading: () => CircularProgressIndicator(),
              error: (error, stackTrace) =>
                  Expanded(
                    child: SingleChildScrollView(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("$error"),
                      ],
                    )),
                  ),
            ),
            (isEmpty.asData?.value == true)
                ? Spacer(flex: 3)
                : SizedBox(height: 24),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SizedBox(
          width: 70,
          height: 70,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => CreateNoteDialog(),
              );
            },
            shape: CircleBorder(),
            backgroundColor: Color(0xff2472E4),
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
