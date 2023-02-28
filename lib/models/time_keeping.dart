class TimeKeeping {
  String? number;
  String? checkin;
  String? checkout;
  String? status;

  TimeKeeping({this.number, this.checkin, this.checkout, this.status});

  TimeKeeping.fromJson(Map<String, dynamic> json) {
    number = json['Number'];
    checkin = json['Checkin'];
    checkout = json['Checkout'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Number'] = this.number;
    data['Checkin'] = this.checkin;
    data['Checkout'] = this.checkout;
    data['Status'] = this.status;
    return data;
  }
}
