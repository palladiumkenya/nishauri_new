import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/shared/display/AppSearch.dart';
import 'package:nishauri/src/utils/constants.dart';

class HIVDrugOrdersScreen extends StatelessWidget {
  const HIVDrugOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text("ARV Drug Orders"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FractionallySizedBox(
        heightFactor: 1,
        child: Column(
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
        ),
      ),
    );
  }
}

final counter = StateProvider<int>((ref) => 0);
