import 'package:hrm_1c/utils/styles.dart';
import 'package:hrm_1c/utils/utils.dart';

class LeaveRequest {
  static final statusColors = [
    HRMColorStyles.pendingColor,
    HRMColorStyles.approveColor,
    HRMColorStyles.denyColor,
  ];

  String? number;
  DateTime? date;
  String? employee;
  DateTime? fromDate;
  DateTime? toDate;
  String? reason;
  String? leaveType;
  String? numberDays;
  String? section;
  String? halfADay;
  String? status;

  LeaveRequest(
      {this.number,
      this.date,
      this.employee,
      this.fromDate,
      this.toDate,
      this.reason,
      this.leaveType,
      this.numberDays,
      this.section,
      this.halfADay,
      this.status});

  LeaveRequest.fromJson(Map<String, dynamic> json) {
    number = json['Number'];
    date = parseDateTimeFromStr(json['Date'].toString());
    employee = json['Employee'];
    fromDate = parseDateTimeFromStr(json['FromDate'].toString());
    toDate = parseDateTimeFromStr(json['ToDate'].toString());
    reason = json['Reason'];
    leaveType = json['LeaveType'];
    numberDays = json['NumberDays'];
    section = json['Section'];
    halfADay = json['HalfADay'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Number'] = this.number;
    data['Date'] = this.date;
    data['Employee'] = this.employee;
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    data['Reason'] = this.reason;
    data['LeaveType'] = this.leaveType;
    data['NumberDays'] = this.numberDays;
    data['Section'] = this.section;
    data['HalfADay'] = this.halfADay;
    data['Status'] = this.status;
    return data;
  }
}
