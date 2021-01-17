import 'package:Notifier_7/widgets/notice-item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';

class AllNotices extends StatefulWidget {
  @override
  _AllNoticesState createState() => _AllNoticesState();
}

class _AllNoticesState extends State<AllNotices> {
  int _value = 0;

  List<dynamic> subscriptionsArray = [];
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      setState(() {
        subscriptionsArray = value['subscriptions'];
        subscriptionsArray.insert(0, 'Public');
        subscriptionsArray.insert(0, 'All');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Query notices;
    if (!subscriptionsArray.isEmpty) {
      notices = FirebaseFirestore.instance.collection('notices').where(
          'channels',
          arrayContainsAny: _value == 0 ? subscriptionsArray : null,
          arrayContains:
              _value == 0 ? null : subscriptionsArray[_value] as String);
    }
    return Column(
      children: [
        Container(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ChoiceChip(
                  label: Text(subscriptionsArray[i]),
                  selected: _value == i,
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected ? i : null;
                    });
                  },
                ),
              );
            },
            itemCount: subscriptionsArray.length,
          ),
        ),
        Divider(),
        Expanded(
          child: notices != null
              ? FutureBuilder<QuerySnapshot>(
                  future: notices.get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      List<QueryDocumentSnapshot> data = snapshot.data.docs;

                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (_, i) => NoticeItem(data[i]));
                      // return Text(data);
                    }

                    return Center(
                      child: Lottie.asset('assets/images/loading.json'),
                      heightFactor: 5,
                    );
                  },
                )
              : SizedBox(
                  height: 0,
                ),
        )
      ],
    );
  }
}
