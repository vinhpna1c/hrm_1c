import 'package:intl/intl.dart';

DateTime parseDateTimeFromStr(String dateStr,
    {String format = "M/dd/y hh:mm:ss a"}) {
  DateTime ret = DateTime.now();

  try {
    ret = DateFormat(format).parse(dateStr);
  } catch (e) {
    print("Error parsing date");
  }
  return ret;
}
