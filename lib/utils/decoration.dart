import 'package:flutter/material.dart';

InputDecoration chooseUsername = InputDecoration(
  enabledBorder: chooseUsernameOutline,
  focusedBorder: chooseUsernameOutline,
  errorBorder: chooseUsernameOutline,
  focusedErrorBorder: chooseUsernameOutline 
);

OutlineInputBorder chooseUsernameOutline = OutlineInputBorder(
    borderSide: const BorderSide(width: 1, color: Colors.white),
    borderRadius: BorderRadius.circular(20)
  );

InputDecoration episodioDescricaoFormfield = const InputDecoration(
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 0)),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 0)));