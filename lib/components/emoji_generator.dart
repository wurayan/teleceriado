import 'dart:async';

import 'package:flutter/material.dart';
import 'package:teleceriado/utils/utils.dart';

class EmojiGenerator extends StatefulWidget {
  final bool generate;
  final TextStyle? style;
  const EmojiGenerator({super.key, required this.generate, this.style});

  @override
  State<EmojiGenerator> createState() => _EmojiGeneratorState();
}

class _EmojiGeneratorState extends State<EmojiGenerator> {
  Timer? timer;
  String emoji = getAvatarPlaceholder();

  changeEmoji() {
    setState(() {
      emoji = getAvatarPlaceholder();
    });
  }

  cancelTimer(){
    if (timer != null) {
      timer!.cancel();
    }
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }

  @override
  void initState() {
    if(widget.generate){
      timer = Timer.periodic(const Duration(seconds: 2), (timer) {
        changeEmoji();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      emoji,
      style: widget.style,
      textAlign: TextAlign.center,
    );
  }
}