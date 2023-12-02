import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nishauri/src/features/hiv/data/providers/art_sites_provider.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/utils/constants.dart';

class ARTSitesScreen extends StatefulWidget {
  const ARTSitesScreen({super.key});

  @override
  State<ARTSitesScreen> createState() => _ARTSitesScreenState();
}

class _ARTSitesScreenState extends State<ARTSitesScreen> {
  late GoogleMapController myController;
  late String _search;

  final LatLng _center = const LatLng(-1.0986984, 36.9666969);

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
      body: Consumer(builder: (context, ref, child) {
        final sites = ref.watch(artSitesProvider);

        return sites.when(
          data: (data) => Stack(
            children: <Widget>[
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 10.0,
                ),
                markers: data
                    .map(
                      (e) => Marker(
                        markerId: MarkerId(e.mflCode),
                        position: LatLng(
                          double.parse(e.address.latitude),
                          double.parse(e.address.longitude),
                        ),
                        infoWindow: InfoWindow(
                            title: e.name,
                            snippet: e.type,
                            onTap: () {
                              showModalBottomSheet(
                                // isScrollControlled: true,
                                context: context,
                                builder: (context) => FractionallySizedBox(
                                  heightFactor: 0.75,
                                  widthFactor: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        Constants.SPACING * 2),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Text(
                                            e.name,
                                            style:
                                                theme.textTheme.headlineLarge,
                                          ),
                                          const SizedBox(
                                              height: Constants.SPACING),
                                          Text(
                                            e.type ?? "",
                                            style: theme.textTheme.titleLarge,
                                          ),
                                          Container(
                                            color: theme.colorScheme
                                                .onTertiaryContainer,
                                            width: double.infinity,
                                            height: 1,
                                          ),
                                          const SizedBox(
                                              height: Constants.SPACING * 2),
                                          Container(
                                            color: theme.colorScheme.background,
                                            margin: const EdgeInsets.only(
                                                top: Constants.SPACING),
                                            child: ListTile(
                                              leading: const Icon(
                                                  Icons.local_hospital),
                                              title: const Text("MFL Code"),
                                              subtitle:
                                                  Text(e.mflCode.toString()),
                                            ),
                                          ),
                                          Container(
                                            color: theme.colorScheme.background,
                                            margin: const EdgeInsets.only(
                                                top: Constants.SPACING),
                                            child: ListTile(
                                              leading: const Icon(Icons.phone),
                                              title: const Text(
                                                  "Telephone Number"),
                                              subtitle:
                                                  Text(e.telephone ?? "None"),
                                            ),
                                          ),
                                          const SizedBox(
                                              height: Constants.SPACING * 2),
                                          Button(title: "Call ${e.telephone ?? ""}", ),
                                          const SizedBox(
                                              height: Constants.SPACING * 2),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                    .toSet(),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: FloatingActionButton(
                    onPressed: () {},
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    child: const Icon(Icons.map, size: 30.0),
                  ),
                ),
              ),
            ],
          ),
          error: (error, _) => Center(child: Text(error.toString())),
          loading: () => Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Getting ART Sites", style: theme.textTheme.titleLarge),
              const SizedBox(height: Constants.SPACING * 2),
              const CircularProgressIndicator(),
            ],
          )),
        );
      }),
    );
  }
}
//
