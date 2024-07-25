import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/blood_sugar/data/providers/blood_sugar_provider.dart';
import 'package:nishauri/src/features/blood_sugar/presentation/pages/AddBloodSugarScreen.dart';
import 'package:nishauri/src/features/blood_sugar/presentation/widgets/blood_sugar_entry_card.dart';

class BloodSugarScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloodSugarState = ref.watch(bloodSugarEntriesProvider);
    debugPrint("Blood Sugar State: ${bloodSugarState.length}");
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Sugar Tracker'),
      ),
      body: bloodSugarState.isEmpty
          ? Center(child: Text('No data available'))
          : ListView.builder(
              itemCount: bloodSugarState.length,
              itemBuilder: (context, index) {
                return BloodSugarEntryCard(entry: bloodSugarState[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBloodSugarScreen()),
          );
          ref.read(bloodSugarEntriesProvider.notifier).refreshEntries();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
