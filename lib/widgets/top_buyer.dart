import 'package:ecommerce_admin_tut/models/top_users.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class TopBuyerWidget extends StatelessWidget {
  final TopUserModel topUser;

  TopBuyerWidget({Key key, this.topUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading:   CircleAvatar(
      //   backgroundImage: AssetImage('images/profile.jpg'),
      // ),
      title: Text(topUser.username),
      subtitle: Text('${topUser.numOrders.toString()}, orders'),
      trailing: CustomText(
        text: '\$ ${topUser.spends.toString()}',
        color: Colors.green.shade800,
        weight: FontWeight.bold,
      ),
    );
  }
}
