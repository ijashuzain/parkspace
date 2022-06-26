import 'package:parkspace/models/area_model.dart';
import 'package:parkspace/models/user_data.dart';

class Booking {
  Area? area;
  String fromDate;
  String fromTime;
  String toTime;
  String status;
  String uid;
  String areaId;
  int slots;
  String? id;
  UserData? user;

  Booking({
    required this.status,
    required this.fromDate,
    required this.fromTime,
    required this.toTime,
    required this.areaId,
    required this.uid,
    required this.slots,
    this.id,
    this.user,
    this.area,
  });

  Booking.fromJson(Map<String, dynamic> json)
      : toTime = json['toTime'],
        fromTime = json['fromTime'],
        fromDate = json['fromDate'],
        uid = json['uid'],
        areaId = json['areaId'],
        id = json['id'],
        area = Area.fromJson(json['area']),
        slots = json['slots'],
        user = UserData.fromJson(json['user']),
        status = json['status'];

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['toTime'] = toTime;
    map['fromTime'] = fromTime;
    map['fromDate'] = fromDate;
    map['areaId'] = areaId;
    map['slots'] = slots;
    map['status'] = status;
    map['uid'] = uid;
    map['id'] = id;
    return map;
  }
}
