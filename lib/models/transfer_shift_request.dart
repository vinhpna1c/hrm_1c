import 'package:hrm_1c/utils/utils.dart';

class TransferShiftRequest {
  String? number;
  DateTime? date;
  String? employeeID;
  String? employee;
  DateTime? shiftMain;
  String? sectionMain;
  DateTime? transferShift;
  String? sectionTransfer;
  DateTime? transferShift2;
  String? sectionTransfer2;
  String? description;
  String? status;
  String? picture;

  TransferShiftRequest(
      {this.number,
      this.date,
      this.employeeID,
      this.employee,
      this.shiftMain,
      this.sectionMain,
      this.transferShift,
      this.sectionTransfer,
      this.transferShift2,
      this.sectionTransfer2,
      this.description,
      this.status,
      this.picture});

  TransferShiftRequest.fromJson(Map<String, dynamic> json) {
    number = json['Number'];
    date = parseDateTimeFromStr(json['Date'].toString());
    employeeID = json['EmployeeID'];
    employee = json['Employee'];
    shiftMain = parseDateTimeFromStr(json['ShiftMain'].toString());
    sectionMain = json['SectionMain'];
    transferShift = parseDateTimeFromStr(json['TransferShift'].toString());
    sectionTransfer = json['SectionTransfer'];
    transferShift2 = parseDateTimeFromStr(json['TransferShift2'].toString());
    sectionTransfer2 = json['SectionTransfer2'];
    description = json['Description'];
    status = json['Status'];
    picture = json['Picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Number'] = this.number;
    data['Date'] = this.date;
    data['EmployeeID'] = this.employeeID;
    data['Employee'] = this.employee;
    data['ShiftMain'] = this.shiftMain;
    data['SectionMain'] = this.sectionMain;
    data['TransferShift'] = this.transferShift;
    data['SectionTransfer'] = this.sectionTransfer;
    data['TransferShift2'] = this.transferShift2;
    data['SectionTransfer2'] = this.sectionTransfer2;
    data['Description'] = this.description;
    data['Status'] = this.status;
    data['Picture'] = this.picture;
    return data;
  }
}
