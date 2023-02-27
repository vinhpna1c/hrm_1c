import 'package:hrm_1c/utils/styles.dart';

class LeaveRequest {
  String? number;
  String? date;
  String? employee;
  String? fromDate;
  String? toDate;
  String? reason;
  String? leaveType;
  String? status;
  String? numberDays;
  String? section;
  String? halfADay;

  static final statusColors = [
    HRMColorStyles.pendingColor,
    HRMColorStyles.approveColor,
    HRMColorStyles.denyColor,
  ];

  LeaveRequest(
      {this.number,
      this.date,
      this.employee,
      this.fromDate,
      this.toDate,
      this.reason,
      this.leaveType,
      this.status,
      this.numberDays,
      this.section,
      this.halfADay});

  LeaveRequest.fromJson(Map<String, dynamic> json) {
    number = json['Number'];
    date = json['Date'];
    employee = json['Employee'];
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
    reason = json['Reason'];
    leaveType = json['LeaveType'];
    status = json['Status'];
    numberDays = json['NumberDays'];
    section = json['Section'];
    halfADay = json['HalfADay'];
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
    data['Status'] = this.status;
    data['NumberDays'] = this.numberDays;
    data['Section'] = this.section;
    data['HalfADay'] = this.halfADay;
    return data;
  }
}
