import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkspace/models/area_model.dart';
import 'package:parkspace/models/map_marker_model.dart';
import 'package:parkspace/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AreaProvider extends ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Area> myAreas = [];
  bool fetchingAreas = false;
  bool creatingArea = false;
  List<MapMarker> mapMarkers = [];
  Set<Marker> markers = {};

  createArea({
    required BuildContext context,
    required Area area,
    required Function onSuccess,
    required Function onError,
  }) async {
    _setCreatingArea(true);
    try {
      var userProvider = context.read<UserProvider>();
      var userId = userProvider.currentUser!.id;
      var docRef = db.collection('areas').doc();
      area.id = docRef.id;
      area.uid = userId!;
      await db.collection("areas").doc(docRef.id).set(area.toMap());
      onSuccess("Success");
      _setCreatingArea(false);
      await fetchAllMyAreas(context);
    } catch (e) {
      _setCreatingArea(false);
      onError(e.toString());
    }
  }

  updateArea({
    required BuildContext context,
    required Area area,
    required Function onSuccess,
    required Function onError,
  }) async {
    _setCreatingArea(true);
    try {
      await db.collection("areas").doc(area.id).update(area.toMap());
      onSuccess("Success");
      _setCreatingArea(false);
      await fetchAllMyAreas(context);
    } catch (e) {
      _setCreatingArea(false);
      onError(e.toString());
    }
  }

  deleteArea({
    required BuildContext context,
    required areaId,
    required Function onSuccess,
    required Function onError,
  }) async {
    _setCreatingArea(true);
    try {
      await db.collection("areas").doc(areaId).delete();
      onSuccess("Success");
      _setCreatingArea(false);
      await fetchAllMyAreas(context);
    } catch (e) {
      _setCreatingArea(false);
      onError(e.toString());
    }
  }

  Future<List<MapMarker>> getMarkers() async {
    try {
      var areaSnap = await db.collection("areas").get();
      mapMarkers = [];
      for (var element in areaSnap.docs) {
        Area area = Area.fromJson(element.data());
        MapMarker mapMarker = MapMarker(
          marker: Marker(
            markerId: MarkerId(area.id.toString()),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(
              double.parse(area.latitude),
              double.parse(area.longitude),
            ),
          ),
          area: area,
        );
        mapMarkers.add(mapMarker);
      }
      return mapMarkers;
    } catch (e) {
      return mapMarkers;
    }
  }

  Future<List<Area>> fetchAllMyAreas(BuildContext context) async {
    _setFetchingAreas(true);
    try {
      var userProvider = context.read<UserProvider>();
      var userId = userProvider.currentUser!.id;
      var areaSnap = await db.collection("areas").where('uid', isEqualTo: userId).get();
      myAreas = [];
      for (var element in areaSnap.docs) {
        Area area = Area.fromJson(element.data());
        myAreas.add(area);
      }
      _setFetchingAreas(false);
      return myAreas;
    } catch (e) {
      _setFetchingAreas(false);
      return myAreas;
    }
  }

  Future<Area?> fetchSingleArea(String areaId) async {
    var areaDoc = await db.collection("areas").doc(areaId).get();
    if (areaDoc.exists) {
      Area area = Area.fromJson(areaDoc.data()!);
      return area;
    } else {
      return null;
    }
  }

  _setCreatingArea(bool val) {
    creatingArea = val;
    notifyListeners();
  }

  _setFetchingAreas(bool val) {
    fetchingAreas = val;
    notifyListeners();
  }
}
