class Contract {
  String? number;
  String? date;
  String? employee;
  String? contractType;
  String? fromDate;
  String? toDate;
  List<TimeSheet>? timeSheet;

  Contract(
      {this.number,
      this.date,
      this.employee,
      this.contractType,
      this.fromDate,
      this.toDate,
      this.timeSheet});

  Contract.fromJson(Map<String, dynamic> json) {
    number = json['Number'];
    date = json['Date'];
    employee = json['Employee'];
    contractType = json['ContractType'];
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
    if (json['TimeSheet'] != null) {
      timeSheet = <TimeSheet>[];
      json['TimeSheet'].forEach((v) {
        timeSheet!.add(new TimeSheet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Number'] = this.number;
    data['Date'] = this.date;
    data['Employee'] = this.employee;
    data['ContractType'] = this.contractType;
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    if (this.timeSheet != null) {
      data['TimeSheet'] = this.timeSheet!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeSheet {
  String? lineNumber;
  String? workDate;
  String? section;

  TimeSheet({this.lineNumber, this.workDate, this.section});

  TimeSheet.fromJson(Map<String, dynamic> json) {
    lineNumber = json['LineNumber'];
    workDate = json['WorkDate'];
    section = json['Section'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LineNumber'] = this.lineNumber;
    data['WorkDate'] = this.workDate;
    data['Section'] = this.section;
    return data;
  }
}
