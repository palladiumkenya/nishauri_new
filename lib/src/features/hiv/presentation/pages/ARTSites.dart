import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/utils/constants.dart';

class ARTSitesScreen extends StatefulWidget {
  const ARTSitesScreen({super.key});

  @override
  State<ARTSitesScreen> createState() => _ARTSitesScreenState();
}

class _ARTSitesScreenState extends State<ARTSitesScreen> {
  late GoogleMapController myController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    myController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text("ART Sites"),
        backgroundColor: theme.primaryColor,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 10.0,
            ),
          ),
          const Center(
            child: Text("Map here"),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => FractionallySizedBox(
                      heightFactor: 0.75,
                      widthFactor: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(Constants.SPACING * 2),
                        child: Column(
                          children: [
                            Text(
                              "Search ART site",
                              style: theme.textTheme.headlineLarge,
                            ),
                            const SizedBox(height: Constants.SPACING),
                            const FormInputTextField(
                              prefixIcon: Icons.search,
                              label: "",
                              placeholder: 'Search',
                            ),
                            const SizedBox(height: Constants.SPACING * 2),
                            Expanded(
                              child: ListView.builder(
                                itemCount: 10,
                                itemBuilder:
                                    (BuildContext context, int index) => Card(
                                  child: ExpansionTile(
                                    title: Text("Site $index"),
                                    leading: const Icon(Icons.local_hospital_outlined),
                                    children: [
                                      Text("Site $index description goes here")
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                materialTapTargetSize: MaterialTapTargetSize.padded,
                child: const Icon(Icons.map, size: 30.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//
