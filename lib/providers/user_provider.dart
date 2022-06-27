import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parkspace/models/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class UserProvider extends ChangeNotifier {
  bool creatingUser = false;
  bool updatingUser = false;
  FirebaseFirestore db = FirebaseFirestore.instance;
  UserData? currentUser;

  createUser({
    required UserData user,
    required Function(String) onSuccess,
    required Function(String) onError,
  }) async {
    _setCreatingUser(true);
    try {
      await db.collection("users").doc(user.id).set(user.toMap());
      await addToLocal(user.id!);
      _setCreatingUser(false);
      onSuccess("User has created successfully");
    } catch (e) {
      _setCreatingUser(false);
      onError(e.toString());
    }
  }

  updateUser({
    required UserData user,
    required Function(String) onSuccess,
    required Function(String) onError,
  }) async {
    _setUpdatingUser(true);
    try {
      await db.collection("users").doc(user.id).update(user.toMap());
      await fetchUser(userId: user.id!, onSuccess: (val) {}, onError: (val) {});
      _setUpdatingUser(false);
      onSuccess("User has updated successfully");
    } catch (e) {
      _setUpdatingUser(false);
      onError(e.toString());
    }
  }

  addToLocal(String userId) async {
    SharedPreferences localdb = await SharedPreferences.getInstance();
    localdb.setString('user', userId);
    log("Added to local db");
  }

  Future<bool> checkLoggedIn() async {
    log("Checking Loggin");
    SharedPreferences localdb = await SharedPreferences.getInstance();
    var result = localdb.get("user");
    bool res = false;
    log("Result : $result");
    if (result != null) {
      await fetchUser(
        userId: result.toString(),
        onSuccess: (val) {
          res = true;
        },
        onError: (val) {
          res = false;
        },
      );
      return res;
    } else {
      return false;
    }
  }

  fetchUser({
    required String userId,
    required Function(UserData) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      var ref = await db.collection("users").doc(userId).get();
      if (ref.data() != null) {
        currentUser = UserData.fromJson(ref.data()!);
        await addToLocal(userId);
        onSuccess(currentUser!);
      } else {
        currentUser = null;
        onError("User not found");
      }
    } catch (e) {
      onError(e.toString());
    }
  }

  Future<UserData?> fetchUserById({required String uid}) async {
    UserData? usr;
    try {
      var ref = await db.collection("users").doc(uid).get();
      if (ref.data() != null) {
        usr = UserData.fromJson(ref.data()!);
      }
      return usr;
    } catch (e) {
      log("Error While Fetching User Data");
      return usr;
    }
  }

  void _setCreatingUser(bool val) {
    creatingUser = val;
    notifyListeners();
  }

  void _setUpdatingUser(bool val) {
    updatingUser = val;
    notifyListeners();
  }
}
