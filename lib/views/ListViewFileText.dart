import 'package:flutter/material.dart';
import 'package:text_edittor/models/FileText.dart';


class ListViewFileText extends StatelessWidget {
  List<FileText> list;
  Function(FileText fileText, int index) onTapItem;
  Function(FileText fileText, int index) onLongPressItem;


  ListViewFileText({this.list, this.onTapItem, this.onLongPressItem});

  Widget buiItem(FileText fileText, int index) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
      color: Colors.brown[100],
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: Colors.brown[400]),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(fileText.fileName, style: TextStyle(
                        fontSize: 18
                      ),),
                      Text(fileText.date),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5,bottom: 1),
            width: 10000,
            height: 1,
            color: Colors.black,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('build list view');
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            onTapItem(list[index], index);
          },
          onLongPress: () {
            onLongPressItem(list[index], index);
          },
          child: buiItem(list[index], index),
        );
      },
    );
  }
}
