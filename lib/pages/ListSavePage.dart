import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:text_edittor/data/DataListFileText.dart';
import 'package:text_edittor/helper/SnackBar.dart';
import 'package:text_edittor/models/FileText.dart';
import 'package:text_edittor/pages/HomePage.dart';
import 'package:text_edittor/pages/ViewFilePage.dart';
import 'package:text_edittor/views/MyDiaLog.dart';
import 'package:text_edittor/views/ListViewFileText.dart';

class ListSavePage extends StatefulWidget {
  static const String pageName = "ListSavedPage";
  @override
  _ListSavePageState createState() {
    return _ListSavePageState();
  }


}

class _ListSavePageState extends State<ListSavePage> with WidgetsBindingObserver {
  final editFileName = TextEditingController();
  GlobalKey<ScaffoldState> key = GlobalKey();
  List<FileText> list = [
    // FileText(fileName: 'file text', content: 'pro', date: '2/2/2020'),
  ];

  void getData() {
    getListFileText().then((value) {
      setState(() {
        list = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    print('intit state');
    getData();
  }

  // notworking
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // if (state == AppLifecycleState.resumed) {
    //   showSnackBar(key, 'resum', 1111);
      print('lsalsals');
    // }
  }

  @override
  Widget build(BuildContext context) {
    print('lol11111111');
    return Scaffold(
        key: key,
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: Text("List File"),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                showDialogAddNewFile(
                    context: context,
                    editFileName: editFileName,
                    onClickCancel: () {},
                    onClickOK: () {
                      if (editFileName.text.isEmpty) {
                        showSnackBar(
                            key, "Tên file không được để trống", 1000);
                      } else {
                        FileText fileText = FileText();
                        fileText.fileName = editFileName.text;
                        fileText.content = '';
                        // fileText.date = DateFormat('dd/MM/yyyy | hh:mm')
                        //     .format(DateTime.now());

                        // Code cũ, thêm file mới có thể gọi hàm addNewFileText()
                        list.insert(0,fileText);

                        Navigator.of(context).pop();
                        saveList(list, onComplete: () {
                          showSnackBar(key, "Thêm file thành công", 1000);
                          setState(() {
                            getData();
                          });
                        });
                      }
                    });
              },
            ),
          ],
        ),
        body: ListViewFileText(
          list: list,
          onTapItem: (fileText, index) {
            Navigator.pushNamed(context, ViewFilePage.pageName,
                arguments: {
                'fileText': fileText,
                 'list': list
            });
          },
          onLongPressItem: (fileText, index) {
            showMyAlertDialog(
                context: context,
                title: "Xoá File",
                mess: "Bạn có muốn xóa file: ${fileText.fileName} không?",
                onClickCancel: () {},
                onClickOk: () {
                  list.remove(fileText);
                  saveList(list, onComplete: () {
                    setState(() {
                      getData();
                      showSnackBar(
                          key, "Đã xóa file: ${fileText.fileName}", 1000);
                    });
                  });
                });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
          onTap: (i) {
            if (i == 0) {
              Navigator.pop(context);
              Navigator.pushNamed(context, HomePage.pageName);
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

    );
  }


}
