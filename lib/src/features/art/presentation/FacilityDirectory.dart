import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/art/model/Facility.dart';
import 'package:nishauri/src/features/art/services/FacilityDirectorySerivice.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';


class FacilityDirectoryScreen extends HookWidget {
  const FacilityDirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final loading = useState(false);
    final facilities = useState<List<Facility>>([]);
    final facilityService = FacilityDirectoryService();
    final theme = Theme.of(context);
    final debouncer = Debouncer(milliseconds: 500);


    onSearchChanged(String query) {
      debouncer.run(() async{
        if(query.length < 3) {
          facilities.value = [];
          return;
        }
        try{
          loading.value = true;
          final results = await facilityService.getfacilities(query);
          facilities.value = results;
        }catch(e){
          facilities.value = [];
          log("*******************$e***********************");
        }
        finally {
          loading.value = false;
        }
      });
    }

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
                    // controller: _controller,
                    onChanged: onSearchChanged,
                    clipBehavior: Clip.antiAlias,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search by name or MFL code ...",
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
              // const SizedBox(
              //   width: Constants.SPACING,
              // ),
              // IconButton.filledTonal(
              //   color: Colors.white,
              //   onPressed: loading.value
              //       ? null
              //       : () {
              //           // _fetchFacilities(_controller.text);
              //         },
              //   icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
              //   style: ButtonStyle(
              //     backgroundColor: MaterialStatePropertyAll<Color>(
              //       Colors.white.withOpacity(0.3),
              //     ),
              //     shape: const MaterialStatePropertyAll<RoundedRectangleBorder>(
              //       RoundedRectangleBorder(
              //         borderRadius: BorderRadius.all(
              //           Radius.circular(Constants.ROUNDNESS * 0.5),
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Constants.SPACING),
                child: facilities.value.isEmpty && !loading.value
                    ? Center(
                        child: Text(
                        'No facilities found',
                        style: theme.textTheme.headlineSmall
                            ?.copyWith(color: theme.disabledColor),
                      ))
                    : loading.value
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                            children: facilities.value
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
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                "${e.name} have no number to call!.")));
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
}
