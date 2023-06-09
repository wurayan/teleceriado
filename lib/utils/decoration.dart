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