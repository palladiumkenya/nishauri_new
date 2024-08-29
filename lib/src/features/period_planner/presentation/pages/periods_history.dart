import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/customCalendar.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';


class PeriodsHistory extends StatefulWidget {
  const PeriodsHistory({super.key});

  @override
  State<PeriodsHistory> createState() => _PeriodsHistoryState();
}

class _PeriodsHistoryState extends State<PeriodsHistory> {
  final averagePeriod = calculateAveragePeriodLength(cycles);
  final averageCycles = calculateAverageCycleLength(cycles);
  // final List<Map<String, String>> periodHistory = [
  // {'start': 'July 1', 'end': 'July 7'},
  // {'start': 'August 1', 'end': 'August 7'},
  // {'start': 'September 2', 'end': 'September 8'},
  // {'start': 'October 3', 'end': 'October 9'},
  // {'start': 'November 4', 'end': 'November 10'},
  // {'start': 'December 5', 'end': 'December 11'},
  // {'start': 'January 6', 'end': 'January 12'},
  // {'start': 'February 7', 'end': 'February 13'},
  // {'start': 'March 8', 'end': 'March 14'},
  // {'start': 'April 9', 'end': 'April 15'},
  // {'start': 'May 10', 'end': 'May 16'},
  // {'start': 'June 11', 'end': 'June 17'},
  // {'start': 'July 12', 'end': 'July 18'},
  // {'start': 'August 13', 'end': 'August 19'},
  // {'start': 'September 14', 'end': 'September 20'},
  // {'start': 'October 15', 'end': 'October 21'},
  // {'start': 'November 16', 'end': 'November 22'},
  // {'start': 'December 17', 'end': 'December 23'},
  // {'start': 'January 18', 'end': 'January 24'},
  // {'start': 'February 19', 'end': 'February 25'},
  // ];

  // Function to format the date as "MMM d"
  String formatDate(DateTime date) {
    return DateFormat('MMM d').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const CustomAppBar(
            title: "My Period History 🌼",
            color: Constants.periodPlanner,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    //The first Card showing both Average period and cycle lengths
                    Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "My Cycles",
                              style:  TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  //Card showing Average Period days 
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Padding(
                                      padding:  const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          const Text(
                                            "Average Period",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            "$averagePeriod days",
                                            style: const TextStyle(
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  //Card Showing Average Cycle days
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Padding(
                                      padding:  const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          const Text(
                                            'Average Cycle',
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            "$averageCycles days",
                                            style: const TextStyle(
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    //Card Showing period history
                    Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                        child: Column(
                            children: [
                            const Text(
                              "History",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cycles.length,
                              itemBuilder: (context, index) {
                                final cycle = cycles[index];
                                final start = formatDate(cycle.periodStart);
                                final end = formatDate(cycle.periodEnd);
                                return ListTile(
                                  title: const Text("2024"),
                                  subtitle: Text(
                                    "$start - $end",
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {}, 
                                    icon: const Icon(Icons.arrow_forward_ios),
                                  ),
                                );
                              }
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}