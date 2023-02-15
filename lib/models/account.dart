class Account {
  String? sId;
  String? accountType;
  String? employeeID;
  String? password;
  String? username;

  Account(
      {this.sId,
      this.accountType,
      this.employeeID,
      this.password,
      this.username});

  Account.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    accountType = json['accountType'];
    employeeID = json['employeeID'];
    password = json['password'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['accountType'] = this.accountType;
    data['employeeID'] = this.employeeID;
    data['password'] = this.password;
    data['username'] = this.username;
    return data;
  }
}
