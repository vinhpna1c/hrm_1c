import 'package:hrm_1c/models/time_keeping.dart';
import 'package:hrm_1c/utils/utils.dart';

class PersonalInformation {
  String? code;
  String? description;
  DateTime? dateOfBirth;
  String? gender;
  String? numberPhone;
  String? identification;
  String? nationality;
  String? email;
  String? address;
  String? maritalStatus;
  String? status;
  double? paidDay;
  double? unpaidDay;
  double? sickLeave;
  String? URL;
  String? position;

  String? contractType;
  List<DependentList>? dependentList;
  TimeKeeping? timeKeeping;

  PersonalInformation(
      {this.code,
      this.description,
      this.dateOfBirth,
      this.gender,
      this.numberPhone,
      this.identification,
      this.nationality,
      this.email,
      this.address,
      this.maritalStatus,
      this.status,
      this.paidDay,
      this.unpaidDay,
      this.sickLeave,
      this.URL,
        this.position,
      this.contractType,
      this.dependentList,
      this.timeKeeping});

  PersonalInformation.  fromJson(Map<String, dynamic> json) {
    // print(json);
    code = json['Code'];
    description = json['Description'];
    dateOfBirth = parseDateTimeFromStr(json['DateOfBirth'].toString());
    gender = json['Gender'];
    numberPhone = json['NumberPhone'];
    identification = json['Identification'];
    nationality = json['Nationality'];
    email = json['Email'];
    address = json['Address'];
    maritalStatus = json['MaritalStatus'];
    status = json['Status'];

    paidDay = double.tryParse(json['PaidDay'].toString().replaceAll(',', '.'));
    unpaidDay = double.tryParse(json['UnpaidDay'].toString());
    sickLeave = double.tryParse(json['SickLeave'].toString());
    URL = json['URL'];
    position = json['Positon'];

    contractType = json['ContractType'];
    if (json['DependentList'] != null) {
      dependentList = <DependentList>[];
      json['DependentList'].forEach((v) {
        dependentList!.add(new DependentList.fromJson(v));
      });
    }
    timeKeeping = json['TimeKeeping'] != null
        ? new TimeKeeping.fromJson(json['TimeKeeping'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Code'] = this.code;
    data['Description'] = this.description;
    data['DateOfBirth'] = this.dateOfBirth;
    data['Gender'] = this.gender;
    data['NumberPhone'] = this.numberPhone;
    data['Identification'] = this.identification;
    data['Nationality'] = this.nationality;
    data['Email'] = this.email;
    data['Address'] = this.address;
    data['MaritalStatus'] = this.maritalStatus;
    data['Status'] = this.status;
    data['PaidDay'] = this.paidDay;
    data['UnpaidDay'] = this.unpaidDay;
    data['SickLeave'] = this.sickLeave;
    data['URL'] = this.URL;
    data['Positon'] = this.position;

    data['ContractType'] = this.contractType;
    if (this.dependentList != null) {
      data['DependentList'] =
          this.dependentList!.map((v) => v.toJson()).toList();
    }
    if (this.timeKeeping != null) {
      data['TimeKeeping'] = this.timeKeeping!.toJson();
    }
    return data;
  }
}

class DependentList {
  String? fullName;
  String? dateOfBirth;
  String? numberPhone;
  String? address;
  String? relationship;

  DependentList(
      {this.fullName,
      this.dateOfBirth,
      this.numberPhone,
      this.address,
      this.relationship});

  DependentList.fromJson(Map<String, dynamic> json) {
    fullName = json['FullName'];
    dateOfBirth = json['DateOfBirth'];
    numberPhone = json['NumberPhone'];
    address = json['Address'];
    relationship = json['Relationship'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FullName'] = this.fullName;
    data['DateOfBirth'] = this.dateOfBirth;
    data['NumberPhone'] = this.numberPhone;
    data['Address'] = this.address;
    data['Relationship'] = this.relationship;
    return data;
  }
}
