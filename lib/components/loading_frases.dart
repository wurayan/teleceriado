import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/utils.dart';

class LoadingFrases extends StatefulWidget {
  final bool loading; 
  const LoadingFrases({super.key, required this.loading});

  @override
  State<LoadingFrases> createState() => _LoadingFrasesState();
}

class _LoadingFrasesState extends State<LoadingFrases> {

  String loadingFrase = getLoadingFrase();
  Timer? timer;

  changeFrase() {
    setState(() {
      loadingFrase = getLoadingFrase();
    });
  }

  cancelTimer() {
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
    if (widget.loading) {
      timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      changeFrase();
    });
    }
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print("esse é o widget de loading frase, vamos ver se fica chamando");
    return Text(
      loadingFrase,
      style: const TextStyle(
        fontSize: 18
      )
    );
  }
}