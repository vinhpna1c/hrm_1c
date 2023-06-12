import 'package:hrm_1c/utils/utils.dart';

class TimeKeeping {
  String? number;
  String? date;
  String? employee;
  DateTime? checkin;
  DateTime? checkout;
  String? status;

  TimeKeeping(
      {this.number,
      this.date,
      this.employee,
      this.checkin,
      this.checkout,
      this.status});

  TimeKeeping.fromJson(Map<String, dynamic> json) {
    number = json['Number'];
    date = json['Date'];
    employee = json['Employee'];
    checkin = parseDateTimeFromStr(json['Checkin'].toString());
    checkout = parseDateTimeFromStr(json['Checkout'].toString());
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Number'] = this.number;
    data['Date'] = this.date;
    data['Employee'] = this.employee;
    data['Checkin'] = this.checkin;
    data['Checkout'] = this.checkout;
    data['Status'] = this.status;
    return data;
  }
}
