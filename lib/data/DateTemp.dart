
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

void setTextTemp(String text,{onComplete()}) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString('text_temp', text);
  if (onComplete != null) {
    onComplete();
  }
  print("save text temp complete");
}

Future<String> getTextTemp() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String text = sharedPreferences.getString('text_temp');
  print('get text temp:'+ text);
  return text;
}