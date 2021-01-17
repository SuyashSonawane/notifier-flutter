import 'package:Notifier_7/provider/subscription.dart';
import 'package:Notifier_7/widgets/channel-item.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Channels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference channels =
        FirebaseFirestore.instance.collection('channels');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "All Channels",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: FutureBuilder<QuerySnapshot>(
            future: channels.get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                List<QueryDocumentSnapshot> data = snapshot.data.docs;

                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (_, i) => ChannelItem(data[i]));
              }

              return Center(
                child: Lottie.asset('assets/images/loading.json'),
                heightFactor: 5,
              );
            },
          ),
        ),
      ],
    );
  }
}
