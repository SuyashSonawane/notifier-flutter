import 'package:Notifier_7/provider/subscription.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChannelItem extends StatelessWidget {
  final data;
  ChannelItem(this.data);

  @override
  Widget build(BuildContext context) {
    final subs = Provider.of<Subscriptions>(context);
    return Column(children: [
      InkWell(
        // onTap: () => Navigator.of(context)
        //     .pushNamed(DetailNotice.routeName, arguments: data),
        splashColor: Theme.of(context).primaryColor,
        child: ListTile(
          leading: CircleAvatar(
            child: Text('123'),
          ),
          title: Text(data['name']),
          subtitle: Text(data['description']),
          trailing: !subs.subs.contains(data['channel'])
              ? IconButton(
                  icon: Icon(
                    Icons.notifications_none,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    Scaffold.of(context).removeCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Subscribed to " + data['name'])));
                    subs.addSubscription(data['channel']);
                  },
                )
              : IconButton(
                  icon: Icon(
                    Icons.notifications_active,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    Scaffold.of(context).removeCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Unsubscribed from " + data['name'])));
                    subs.removeSubscription(data['channel']);
                  }),
        ),
      ),
      Divider(),
    ]);
  }
}
