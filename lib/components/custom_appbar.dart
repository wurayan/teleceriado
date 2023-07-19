import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: InkWell(
        onTap: (){
          Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width*0.02,
            top: MediaQuery.of(context).size.height*0.01,
          ),
          child: const CircleAvatar(
            backgroundColor: Colors.white24,
            child: Icon(
              Icons.arrow_back_ios_rounded
            ),
          ),
        ),
      )
    );
  }
}
