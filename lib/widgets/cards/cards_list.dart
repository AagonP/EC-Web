import 'package:flutter/material.dart';
import 'package:ecommerce_admin_tut/provider/tables.dart';
import 'card_item.dart';

class CardsList extends StatelessWidget {
  final TablesProvider tablesProvider;

  CardsList({Key key, this.tablesProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CardItem(
              icon: Icons.monetization_on_outlined,
              title: "Revenue",
              subtitle: "Revenue this month",
              value: "\$ ${tablesProvider.revenueThisMonth}",
              color1: Colors.green.shade700,
              color2: Colors.green,
            ),
            CardItem(
              icon: Icons.shopping_basket_outlined,
              title: "Foods",
              subtitle: "Total foods on store",
              value: "${tablesProvider.foods.length}",
              color1: Colors.lightBlueAccent,
              color2: Colors.blue,
            ),
            CardItem(
              icon: Icons.delivery_dining,
              title: "Orders",
              subtitle: "Total orders for this month",
              value: "${tablesProvider.ordersThisMonth.length}",
              color1: Colors.redAccent,
              color2: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
