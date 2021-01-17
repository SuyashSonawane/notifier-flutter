import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Subscriptions with ChangeNotifier {
  List<dynamic> _subs = ['All'];
  DocumentReference ref;
  Subscriptions() {
    fetch();
  }
  void setSubs(List<dynamic> subs) {
    this._subs = subs;
  }

  void fetch() {
    ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid);
    ref.get().then((value) {
      _subs = value['subscriptions'];
      notifyListeners();
    });
  }

  List<dynamic> get subs {
    Subscriptions();
    return _subs;
  }

  void addSubscription(channelName) {
    _subs.add(channelName);
    ref.update({'subscriptions': _subs});
    notifyListeners();
  }

  void removeSubscription(channelName) {
    _subs.removeWhere((val) => val == channelName);
    ref.update({'subscriptions': _subs});
    notifyListeners();
  }
}
