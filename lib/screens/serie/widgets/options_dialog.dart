import 'package:flutter/material.dart';

class OptionsButton extends StatefulWidget {
  const OptionsButton({super.key});

  @override
  State<OptionsButton> createState() => _OptionsButtonState();
}

class _OptionsButtonState extends State<OptionsButton> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isTapped= !isTapped;
        });
        showDialog(
            context: context,
            builder: (context) => const OptionsDialog()).then((value) {
          setState(() {
            isTapped = !isTapped;
          });
        });
      },
      child: isTapped
          ? const SizedBox(
              width: null,
              height: null,
            )
          : const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white24,
              child: Icon(
                Icons.more_vert_rounded,
                size: 32,
              ),
            ),
    );
  }
}

class OptionsDialog extends StatelessWidget {
  const OptionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * 0.01, right: width * 0.02),
              child: Container(
                width: width*0.33,
                // height: height*0.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white54),
                child: Column(
                  children: [
                    TextButton(
                      onPressed: (){}, 
                      child: const Text('Editar imagem', style:TextStyle(color: Colors.black))),
                    const Divider(
                      height: 3,
                      color: Colors.black,
                    ),
                    TextButton(onPressed: (){}, child: const Text('Editar Descrição', style:TextStyle(color: Colors.black))),
                    const Divider(
                      height: 3,
                      color: Colors.black,),
                    TextButton(onPressed: (){}, child: const Text('Compartilhar',  style:TextStyle(color: Colors.black)))
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
