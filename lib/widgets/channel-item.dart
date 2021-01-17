import 'package:Notifier_7/screens/detail-notice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChannelItem extends StatefulWidget {
  final data;
  ChannelItem(this.data);

  @override
  _ChannelItemState createState() => _ChannelItemState();
}

class _ChannelItemState extends State<ChannelItem> {
  void addSubscription(context) async {
    // DocumentReference ref = FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(FirebaseAuth.instance.currentUser.uid);
    // DocumentSnapshot data = await ref.get();

    // List<dynamic> subArray = data['subscriptions'];

    // subArray.add(this.data['channel']);

    // await ref.update({'subscriptions': subArray});

    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("${widget.data['name']} subscribed"),
    ));
  }

  bool isSubscribed = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed(DetailNotice.routeName, arguments: widget.data),
        splashColor: Theme.of(context).primaryColor,
        child: ListTile(
          leading: CircleAvatar(
            child: Text('123'),
          ),
          title: Text(widget.data['name']),
          subtitle: Text(widget.data['description']),
          trailing: !isSubscribed
              ? IconButton(
                  icon: Icon(
                    Icons.notifications_none,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    // showDialog(
                    //   context: context,
                    //   builder: (context) => AlertDialog(
                    //     title: Text("Do you want to add subscription ?"),
                    //     content: Column(
                    //       children: [],
                    //     ),
                    //     actions: [
                    //       FlatButton(onPressed: () {}, child: Text("Yup!")),
                    //       FlatButton(onPressed: () {}, child: Text("Nope")),
                    //     ],
                    //   ),
                    // );
                    addSubscription(context);
                  },
                )
              : IconButton(
                  icon: Icon(Icons.notifications_active), onPressed: () {}),
        ),
      ),
      Divider(),
    ]);
  }
}
