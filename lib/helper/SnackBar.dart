
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSnackBar(GlobalKey<ScaffoldState> key, String mess, int miliseconds) {
  key.currentState.showSnackBar(
      SnackBar(
        content: Text(mess),
        duration: Duration(milliseconds: miliseconds),
      )
  );
}
