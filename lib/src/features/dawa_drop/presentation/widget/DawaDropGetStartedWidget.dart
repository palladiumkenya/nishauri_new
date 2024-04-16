import 'package:flutter/material.dart';
import 'package:nishauri/src/features/appointments/presentation/pages/Appointments.dart';
import 'package:nishauri/src/shared/input/Button.dart';

class DawaDropGetStartedWidget extends StatefulWidget {
  @override
  _DawaDropGetStartedWidgetState createState() =>
      _DawaDropGetStartedWidgetState();
}

class _DawaDropGetStartedWidgetState extends State<DawaDropGetStartedWidget> {
  late bool _loading;
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    _loading = false;
  }

  void _navigateToCurrentAppointments() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Appointments()));
  }

  void _navigateToOngoing() {
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => OngoingScreen()));
  }

  void _navigateBasedOnSelection() {
    if (selectedOption == "In a program") {
      _navigateToCurrentAppointments();
    } else if (selectedOption == "Not In a program") {
      _navigateToOngoing();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<Widget> screenRoutes = [
      RadioListTile<String>(
        title: const Text('With a program'),
        value: 'In a program',
        groupValue: selectedOption,
        onChanged: (value) {
          setState(() {
            selectedOption = value;
          });
        },
      ),
      RadioListTile<String>(
        title: const Text('With out program'),
        value: 'Not In a program',
        groupValue: selectedOption,
        onChanged: (value) {
          setState(() {
            selectedOption = value;
          });
        },
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text("Getting Started"),
      ),
      body: SafeArea(
        child: this._loading == true
            ? Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).backgroundColor),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
        )
            : SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: Colors.grey[200], // Background color for the image
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "assets/images/shopping-meds.png",
                    fit: BoxFit.cover, // Adjust the image fit as needed
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    "Select one of the options to proceed.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  width: 200,
                  height: 140,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: screenRoutes,
                  ),
                ),
                ElevatedButton(
                  onPressed: _navigateBasedOnSelection,
                  child: Text('Next'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
