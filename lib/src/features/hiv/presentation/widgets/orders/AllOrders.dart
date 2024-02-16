import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/display/AppSearch.dart';
import 'package:nishauri/src/utils/constants.dart';

class AllOrders extends StatelessWidget {
  const AllOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(Constants.SPACING),
          child: AppSearch(),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int currIndex) => Column(
              children: [
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.shopping_cart),
                  title: Text("Order $currIndex name here"),
                  subtitle: Text("$currIndex October 2023"),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
