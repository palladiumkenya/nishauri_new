import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/utils/constants.dart';

class ARTSitesScreen extends StatefulWidget {
  const ARTSitesScreen({super.key});

  @override
  State<ARTSitesScreen> createState() => _ARTSitesScreenState();
}

class _ARTSitesScreenState extends State<ARTSitesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text("ART Sites"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FractionallySizedBox(
        heightFactor: 1,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(Constants.SPACING),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.search),
                          border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    width: Constants.SPACING * 2,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      color: Theme.of(context).colorScheme.outlineVariant,
                      borderRadius: BorderRadius.circular(Constants.ROUNDNESS),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_list_alt, size: 45,),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int currIndex) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.local_hospital_outlined),
                    title: Text("ART Site $currIndex level $currIndex"),
                    subtitle: Text("07655678$currIndex"),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
