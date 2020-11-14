
import 'package:intl/intl.dart';

String getCurrentTime() {
  DateTime now = DateTime.now();
  String date = DateFormat('dd/MM/yyyy | hh:mm a').format(now);
  return date;
}