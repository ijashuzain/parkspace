import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkspace/models/area_model.dart';

class MapMarker {
  Marker marker;
  Area area;

  MapMarker({
    required this.marker,
    required this.area,
  });
}
