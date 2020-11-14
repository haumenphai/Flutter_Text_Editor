
import 'package:flutter/material.dart';
import 'package:text_edittor/data/DataListFileText.dart';
import 'package:text_edittor/data/DateTemp.dart';
import 'package:text_edittor/helper/SnackBar.dart';
import 'package:text_edittor/helper/TimeHelper.dart';
import 'package:text_edittor/models/FileText.dart';
import 'package:text_edittor/pages/ListSavePage.dart';
import 'package:text_edittor/views/MyDiaLog.dart';

class HomePage extends StatefulWidget {
  static const String pageName = "HomePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  bool isEditing = false;
  TextEditingController textEditingController = TextEditingController();
  final GlobalKey<ScaffoldState> key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setState(() {
      getTextTemp().then((text) => textEditingController.text = text);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print('resumed');
    }

    if (state == AppLifecycleState.paused) {
      print('paused');
      setTextTemp(textEditingController.text);
    }

  }

  @override
  Widget build(BuildContext context) {
    final editAddFileNameControler = TextEditingController();

    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("Text Edittor"),
        backgroundColor: Colors.brown,
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: isEditing? Colors.white: Colors.grey,
            ),
            onPressed: () {
              // print(getCurrentTime());
              setState(() {
                isEditing = !isEditing;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              showDialogAddNewFile(
                title: "Save file",
                context: context,
                editFileName: editAddFileNameControler,
                onClickOK: () {
                  if(editAddFileNameControler.text.isEmpty) {
                    showSnackBar(key, "Tên file không được để trống", 1000);
                  } else {
                    FileText fileText = FileText();
                    fileText.fileName = editAddFileNameControler.text;
                    fileText.content = textEditingController.text;
                    addNewFileText(fileText, onComple: () {
                      showSnackBar(key, "Lưu thành thành công", 1000);
                      Navigator.pop(context);
                    });
                  }
                }
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showMyAlertDialog(
                context: context,
                title: "Delete temp text?",
                mess: 'Xóa nội dung văn bản nháp?',
                onClickOk: () {
                  setState(() {
                    textEditingController.text = '';
                  });
                }
              );
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (i) {
          if (i == 1) {
            Navigator.pop(context);
            Navigator.pushNamed(context, ListSavePage.pageName);
            setTextTemp(textEditingController.text);
          }
        },
        selectedItemColor: Colors.blueAccent,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_outlined),
              label: "list saved"
          )
        ],
      ),
      body: Container(
        color: Colors.brown[100],
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                enabled: isEditing? true:false,
                controller: textEditingController,
                decoration: InputDecoration(hintText: "write here"),
                maxLines: null,

              ),
            )
          ],
        ),
      ),
    );
  }




}
