
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_edittor/models/FileText.dart';

Future<List<FileText>> getListFileText()  async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String json = sharedPreferences.getString('listFileText');
  List<FileText> list = [];
  if(json != null) {
     final map = jsonDecode(json);
     map.forEach((element) {
       FileText fileText = FileText.fromJson(element);
       list.add(fileText);
     });
  }

  print('getList: ${list.length}');
  return list;
}

void saveList(List<FileText> list, {Function onComplete}) async {
  var json = jsonEncode(list);
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString('listFileText', json);
  print('save list');
  if(onComplete != null) {
    onComplete();
  }
}

void addNewFileText(FileText fileText, {@required onComple()}) async {
  List<FileText> list = await getListFileText();
  list.insert(0, fileText);
  await saveList(list);
  onComple();
  print('add new file text: ${fileText.fileName}');
}















