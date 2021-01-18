import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Subscriptions with ChangeNotifier {
  List<dynamic> _subs = ['All'];
  DocumentReference ref;
  FirebaseMessaging fm = FirebaseMessaging();

  void setSubs(List<dynamic> subs) {
    this._subs = subs;
  }

  void fetch() {
    if (FirebaseAuth.instance.currentUser != null) {
      ref = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid);
      ref.get().then((value) {
        _subs = value['subscriptions'];
        _subs.forEach((e) {
          fm.subscribeToTopic(e).whenComplete(() => print(e));
        });
        notifyListeners();
      });
    }
  }

  List<dynamic> get subs {
    Subscriptions();
    return _subs;
  }

  void addSubscription(channelName) {
    _subs.add(channelName);
    ref.update({'subscriptions': _subs});
    fm.subscribeToTopic(channelName);
    notifyListeners();
  }

  void removeSubscription(channelName) {
    _subs.removeWhere((val) => val == channelName);
    ref.update({'subscriptions': _subs});
    fm.unsubscribeFromTopic(channelName);
    notifyListeners();
  }
}
