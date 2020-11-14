
import 'package:flutter/material.dart';

void showMyAlertDialog(
    {BuildContext context, String title, String mess,
  Function onClickOk,
  Function onClickCancel})
{
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed:  () {
      Navigator.of(context).pop();
      onClickCancel.call();
    },
  );
  Widget continueButton = FlatButton(
    child: Text("OK"),
    onPressed:  () {
      onClickOk.call();
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(mess),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void showDialogAddNewFile(
    {BuildContext context, TextEditingController editFileName,
      Function onClickCancel,
      Function onClickOK,
      String title = 'Enter file name'
    }
    ) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)), //this right here
          child: Container(
            height: 200.0,
            width: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 5,),
                Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown),
                  ),
                ),
                Container(
                  height: 70,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: editFileName,
                    decoration: InputDecoration(
                        labelText: "File Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)))),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        if(onClickCancel != null) {
                          onClickCancel.call();
                        }
                      },
                    ),
                    FlatButton(
                      child: Text(
                        'OK',
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () {
                        onClickOK.call();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}
