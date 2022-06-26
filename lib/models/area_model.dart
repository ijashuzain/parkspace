class Area {
  String areaName;
  String areaAddress;
  int slots;
  bool cameraStatus;
  bool nightParking;
  int bookedSlots;
  String latitude;
  String longitude;
  int rate;
  String? uid;
  String? id;

  Area({
    required this.areaName,
    required this.areaAddress,
    required this.slots,
    required this.cameraStatus,
    required this.nightParking,
    required this.bookedSlots,
    required this.latitude,
    required this.longitude,
    required this.rate,
    this.uid,
    this.id,
  });

  Area.fromJson(Map<String, dynamic> json)
      : areaName = json['areaName'],
        areaAddress = json['areaAddress'],
        slots = json['slots'],
        cameraStatus = json['cameraStatus'],
        nightParking = json['nightParking'],
        bookedSlots = json['bookedSlots'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        rate = json['rate'],
        id = json['id'],
        uid = json['uid'];

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['areaName'] = areaName;
    map['areaAddress'] = areaAddress;
    map['slots'] = slots;
    map['cameraStatus'] = cameraStatus;
    map['nightParking'] = nightParking;
    map['bookedSlots'] = bookedSlots;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['rate'] = rate;
    map['id'] = id;
    map['uid'] = uid;
    return map;
  }
}
