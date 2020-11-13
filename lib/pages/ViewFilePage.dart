import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:text_edittor/data/DataListFileText.dart';
import 'package:text_edittor/helper/SnackBar.dart';
import 'package:text_edittor/models/FileText.dart';
import 'package:text_edittor/pages/HomePage.dart';
import 'package:text_edittor/views/MyDiaLog.dart';

class ViewFilePage extends StatefulWidget {
  static const String pageName = "ViewFilePage";
  @override
  _ViewFilePageState createState() => _ViewFilePageState();
}

class _ViewFilePageState extends State<ViewFilePage> {
  bool enableEditText = false;
  Color colorEditIcon = Colors.white38;
  bool editting = false;
  TextEditingController textEditingControler = TextEditingController();
  GlobalKey<ScaffoldState> key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map = ModalRoute.of(context).settings.arguments;
    FileText fileText = map['fileText'];
    textEditingControler.text = fileText.content;
    List<FileText> list = map['list'];

    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(fileText.fileName),
        backgroundColor: Colors.brown,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: colorEditIcon,),
            onPressed: () {
              editting = !editting;
              colorEditIcon = editting? Colors.white: Colors.white38;
              enableEditText = editting;
              setState(() {

              });
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              showMyAlertDialog(
                context: context,
                title: "Lưu File",
                mess: "Bạn có muốn lưu nội dung chỉnh sửa?",
                onClickOk: () {
                  list.forEach((element) {
                    if (element.content == fileText.content
                        && element.fileName == fileText.fileName
                        && element.date== fileText.date)
                    {
                      element.content = textEditingControler.text;
                    }
                  });

                  saveList(list, onComplete: () {
                    showSnackBar(key, "Lưu nội dung thành công", 1000);
                    setState(() {
                      enableEditText = false;
                    });
                  });

                }
              );

            },
          )
        ],
      ),
      body: Container(
        width: 10000,
        height: 1000,
        padding: EdgeInsets.all(10),
        child: TextField(
          controller: textEditingControler,
          maxLines: null,
          enabled: enableEditText,
        ),
      ),
    );
  }
}
