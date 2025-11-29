import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Color(0xffF7F5F3), 
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 10),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Color(0xff1B6CDF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: SvgPicture.asset(
                  "assets/icons/note_icon.svg",
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  width: 35,
                  height: 35,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Thinkly",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 40,
                      color: Color(0xff2A303A)
                    ),
                    ),
                  Text(
                    "Start capturing your ideas",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Color(0xff666E7E)
                    ),
                    )
                  
                  ]
                
                ),
            ),
          ],
        ),
      ),
    );
  }
}
