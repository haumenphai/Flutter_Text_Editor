
import 'dart:io';

class FileText {
  String fileName;
  String content;
  String date;

  FileText({this.fileName, this.content, this.date});
  Map toJson() => {
    'fileName': fileName,
    'content': content,
    'date': date
  };

  factory FileText.fromJson(Map<String, dynamic> json) {
    return FileText(
        fileName: json['fileName'],
        content: json['content'],
        date: json['date']
    );
  }

}