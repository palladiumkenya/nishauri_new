import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:nishauri/src/features/art/FacilityHTTPService.dart';

import 'dart:convert';
import 'package:nishauri/src/features/art/model/Facility.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/input/Search.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';

import '../../../shared/interfaces/HTTPService.dart';
import '../../auth/data/respositories/auth_repository.dart';
import '../../auth/data/services/AuthApiService.dart';

class FacilityDirectory extends StatefulWidget {
  @override
  _FacilityDirectoryState createState() => _FacilityDirectoryState();
}

class _FacilityDirectoryState extends State<FacilityDirectory> {
  TextEditingController _controller = TextEditingController();
  List<Facility> _facilities = [];
  bool _fetching = false;

  final AuthRepository _repository = AuthRepository(AuthApiService());
  final HTTPService _httpService =
      FacilityHTTPService(); // Instantiate HTTPService

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          CustomAppBar(
            title: "Facility Directory",
            icon: Icons.local_hospital,
            color: Constants.facilityDirectoryColor,
            bottom: Row(children: [
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        Constants.ROUNDNESS * 0.5,
                      ),
                    ),
                  ),
                  child: TextField(
                    controller: _controller,
                    clipBehavior: Clip.antiAlias,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search for facility by name or code",
                        prefixIcon: const Icon(
                          Icons.search_outlined,
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.3),
                        hintStyle: const TextStyle(color: Colors.white)),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: Constants.SPACING,
              ),
              IconButton.filledTonal(
                color: Colors.white,
                onPressed: _fetching
                    ? null
                    : () {
                        _fetchFacilities(_controller.text);
                      },
                icon: const Icon(Icons.tune),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                    Colors.white.withOpacity(0.3),
                  ),
                  shape: const MaterialStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(Constants.ROUNDNESS * 0.5),
                      ),
                    ),
                  ),
                ),
              )
            ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Constants.SPACING),
                child: _facilities.isEmpty && !_fetching
                    ? Center(
                        child: Text(
                        'No facilities found',
                        style: theme.textTheme.headlineSmall
                            ?.copyWith(color: theme.disabledColor),
                      ))
                    : _fetching
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                            children: _facilities
                                .map(
                                  (e) => Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                          Constants.SPACING),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  e.name,
                                                  style: theme
                                                      .textTheme.titleMedium
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                ),
                                                const SizedBox(
                                                    height: Constants.SPACING),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.pin_drop,
                                                      color: theme
                                                          .colorScheme.primary,
                                                    ),
                                                    const SizedBox(
                                                      width: Constants.SPACING,
                                                    ),
                                                    Expanded(
                                                        child: Text(e.county,
                                                            style: const TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis)))
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.phone_forwarded,
                                                      color: theme
                                                          .colorScheme.primary,
                                                    ),
                                                    const SizedBox(
                                                      width: Constants.SPACING,
                                                    ),
                                                    Expanded(
                                                        child: Text(e.telephone,
                                                            style: const TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis)))
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .location_city_outlined,
                                                      color: theme
                                                          .colorScheme.primary,
                                                    ),
                                                    const SizedBox(
                                                      width: Constants.SPACING,
                                                    ),
                                                    Expanded(
                                                        child: Text(
                                                            "MFL Code: ${e.code}",
                                                            style: const TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis))),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.local_hospital,
                                                      color: theme
                                                          .colorScheme.primary,
                                                    ),
                                                    const SizedBox(
                                                      width: Constants.SPACING,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        e.facilityType,
                                                        style: const TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: theme.colorScheme.primary
                                                    .withOpacity(0.4),
                                                shape: BoxShape.circle),
                                            child: IconButton(
                                                onPressed: () async {
                                                  if (e.telephone
                                                      .replaceAll(" ", "")
                                                      .isEmpty) {
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${e.name} have no number to call!.")));
                                                    return;
                                                  }
                                                  final numberToCall =
                                                      await showDialog<String?>(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      title: const Text(
                                                          "Call facility"),
                                                      content:
                                                          SingleChildScrollView(
                                                        child: Wrap(
                                                          children: e.telephone
                                                              .replaceAll(
                                                                  "CCC:", "")
                                                              .replaceAll(
                                                                  " ", "")
                                                              .split(",")
                                                              .map(
                                                                (el) =>
                                                                    ListTile(
                                                                  title:
                                                                      Text(el),
                                                                  leading:
                                                                      const Icon(
                                                                          Icons
                                                                              .phone_forwarded_outlined),
                                                                  onTap: () =>
                                                                      context.pop(
                                                                          el),
                                                                ),
                                                              )
                                                              .toList(),
                                                        ),
                                                      ),
                                                      actions: [
                                                        Button(
                                                          title: "Cancel",
                                                          onPress: () =>
                                                              context.pop(),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                  if (numberToCall != null) {
                                                    makePhoneCall(numberToCall);
                                                  }
                                                },
                                                icon: const Icon(
                                                    Icons.phone_forwarded)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchFacilities(String queryParameter) async {
    setState(() {
      _facilities.clear();
      _fetching = true;
    });

    final id = await _repository.getUserId();
    final token = await _repository.getAuthToken();
    final token2 = await _httpService.getCachedToken();

    // var headers = {'Authorization':"Bearer ${token2.accessToken}",
    //   'Content-Type': 'application/json'};

    // Define headers
    Map<String, String> headers = {
      'Authorization': 'Bearer ${token2.accessToken}',
      'Content-Type': 'application/json',
    };

    String url =
        'https://ushauriapi.kenyahmis.org/nishauri_new/artdirectory?name=$queryParameter&user_id=$id';
// =======
//     String baseUrl = 'http://prod.kenyahmis.org:8002/api/facility/directory';
//     String url = '$baseUrl?name=$queryParameter';
// >>>>>>> 48aaf36 (:construction: Add dawa drop global)

    try {
      // http.Response response = await http.get(Uri.parse(url));
      http.Response response = await http.get(Uri.parse(url), headers: headers);

      print('API Response: ${response.statusCode} ${response.body}');
      print('Cached Token: $headers');
      print('userID: $id');

      dynamic responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('message')) {
        dynamic messageData = responseBody['message'];
        if (messageData is List) {
          List<dynamic> jsonList = messageData;
          if (jsonList != null) {
            setState(() {
              _facilities =
                  jsonList.map((json) => Facility.fromJson(json)).toList();
              _fetching = false;
            });
          } else {
            print('Failed to load facilities: ${response.statusCode}');
            setState(() {
              _fetching = false;
            });
            _showToast('No facilities found');
          }
        } else if (messageData is String) {
          // Handle the case where 'message' is a string
          print('Response message: $messageData');
          // Display or handle the string message accordingly
        } else {
          print('Unexpected message format: $messageData');
          // Handle unexpected format accordingly
        }
      } else {
        print('Response does not contain message key');
        // Handle the case where 'message' key is missing from the response
      }

      //if (response.statusCode == 200) {
      //   List<dynamic> jsonList = jsonDecode(response.body)['message'];
      //   if (jsonList != null) {
      //     setState(() {
      //       _facilities = jsonList.map((json) => Facility.fromJson(json)).toList();
      //       _fetching = false;
      //     });
      //   } else {
      //     print('Failed to load facilities: ${response.statusCode}');
      //     setState(() {
      //       _fetching = false;
      //     });
      //     _showToast('No facilities found');
      //   }
      // } else {
      //   print('Failed to load facilities. Error: ${response.statusCode}');
      //   setState(() {
      //     _fetching = false;
      //   });
      // }
    } catch (e) {
      print('Exception while fetching facilities: $e');
      setState(() {
        _fetching = false;
      });
    }
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
