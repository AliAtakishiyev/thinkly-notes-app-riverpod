import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thinkly_app/features/notes/widgets/create_note_dialog.dart';
import 'package:thinkly_app/utils/screen_size.dart';

class NoNotes extends StatelessWidget {
  const NoNotes({super.key});

  @override
  Widget build(BuildContext context) {


    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        0.1,
                      ), // Shadow color with opacity
                      spreadRadius: 3, // How much shadow spreads
                      blurRadius: 12, // How blurry the shadow is
                      offset: Offset(
                        0,
                        4,
                      ), // Horizontal and vertical offset (x, y)
                    ),
                  ],
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SvgPicture.asset(
                    "assets/icons/note_icon.svg",
                    colorFilter: ColorFilter.mode(
                      Color(0xff1B6CDF),
                      BlendMode.srcIn,
                    ),
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
            ),

            Text(
              "No notes yet",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 40,
                color: Color(0xff2A303A),
              ),
            ),

            Text(
              "Start capturing your thoughts, ideas, and reminders in one beautiful place",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
                color: Color(0xff2A303A),
              ),
            ),

            SizedBox(height: 24),

            SizedBox(
              height: 48,
              width: ScreenSize.width(context) * 0.6,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff2679E8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => CreateNoteDialog(),
                  );

                  
                },
                child: Text(
                  "+ Create Your First Note",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
