import 'package:Notifier_7/screens/detail-notice.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoticeItem extends StatelessWidget {
  final data;
  NoticeItem(this.data);
  @override
  Widget build(BuildContext context) {
    final datetime = DateTime.fromMicrosecondsSinceEpoch(data['ts']);
    return Column(children: [
      InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed(DetailNotice.routeName, arguments: data),
        splashColor: Theme.of(context).primaryColor,
        child: ListTile(
          leading: CircleAvatar(
            child: Text('123'),
          ),
          title: Text(data['title']),
          subtitle: Text(
              "${data['authorName']} ${DateFormat('dd/MM/yy').format(datetime)}"),
        ),
      ),
      Divider(),
    ]);
  }
}
