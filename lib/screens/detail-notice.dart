import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailNotice extends StatelessWidget {
  static const routeName = '/details';
  @override
  Widget build(BuildContext context) {
    final qureydata =
        ModalRoute.of(context).settings.arguments as QueryDocumentSnapshot;

    Map data = qureydata.data();

    List<dynamic> divisons = data['divisions'];
    List<dynamic> years = data['years'];
    final datetime = DateTime.fromMicrosecondsSinceEpoch(data['ts']);
    final date = DateFormat('dd/MM/yy hh:mm').format(datetime);

    return Scaffold(
        appBar: AppBar(
          title: Text('Detailed Notice'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (data.containsKey('imageUrl'))
                Container(
                  width: double.infinity,
                  child:
                      // FadeInImage.memoryNetwork(
                      //     placeholder: null, image: null)
                      Image.network(
                    data['imageUrl'],
                    fit: BoxFit.cover,
                  ),
                ),
              SizedBox(
                height: 10,
              ),
              Text(data['title']),
              Text(data['authorName']),
              Text(data['content']),
              Text(divisons.join(",")),
              Text(years.join(",")),
              Text(date),
            ],
          ),
        ));
  }
}
