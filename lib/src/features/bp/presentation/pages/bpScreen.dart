import 'package:flutter/material.dart';

class BPScreen extends StatelessWidget {
  const BPScreen({super.key});

  @override
  Widget buil(BuildContext  context) {

    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation){
          // if (orientation == Orientation.landscape) {
          //   return MeasurementGraph(
          //     height: MediaQuery.of(context).size.height,
          //   );
          // }

          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Consumer<IntervallStoreManager>(builder: (context, intervalls, child) =>
                  Column(
                    children: [
                      // const MeasurementGraph(),
                      Expanded(
                          child: BloodPressureBuilder(
                            rangeType: IntervallStoreManagerLocation.mainPage,
                            onData: (context, records) => RepositoryBuilder<MedicineIntake, MedicineIntakeRepository>(
                              rangeType: IntervallStoreManagerLocation.mainPage,
                              onDate: (BuildContext context, List<Note> notes) {
                                final entries = FullEntryList.merged(records, notes, intakes);
                                entries.sort((a,b) => b.time.compareTo(a.time)); //newest first.
                              }
                            )
                          )),
                    ],
                  )
              ),
            ),
          );
        },
      ),
    );
  }

}