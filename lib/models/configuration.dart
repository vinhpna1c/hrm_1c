// class Configuration {
//   double checkInRadius;
//   double longitude;
//   double latitude;
//
//   Configuration(
//       {this.checkInRadius=0.0,
//         this.longitude=0.0,
//         this.latitude=0.0});
//
//   Configuration.fromJson(Map<String, dynamic> json) {
//     checkInRadius = double.parse(json['CheckInRadius']);
//     longitude = double.parse(json['Longtitude']);
//     latitude = double.parse(json['Latitude']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['CheckInRadius'] = this.checkInRadius;
//     data['Longtitude'] = this.longitude;
//     data['Latitude'] = this.latitude;
//     return data;
//   }
// }