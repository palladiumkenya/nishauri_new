import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/provider/provider_registry/data/providers/provider_registry_provider.dart';
import 'package:nishauri/src/hooks/use_local_avatar.dart';
import 'package:nishauri/src/shared/display/ProfileCard.dart';
import 'package:nishauri/src/shared/extensions/extensions.dart';
import 'package:nishauri/src/utils/constants.dart';

class ProviderDetails extends HookWidget {
  const ProviderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final avatar = useLocalAvatar("images/avatar.jpg");
    log("*****************${avatar.toString()}*********************");
    final cardColor = Theme.of(context).colorScheme.onPrimary;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text('Provider Details'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final userAsync = ref.watch(getProviderDetailsProvider);
          return userAsync.when(
            data: (provider) => ProfileCard(
              height: MediaQuery.of(context).size.height,
              color: Constants.providerBgColor,
              header: Text(("${provider.salutation ?? " "} ${provider.family_name ?? " "} ${provider.given_name ?? " "}").titleCase),
              image: avatar,
              // user.image,
              icon: Icons.person,
              buildItem: (context, item) => item,
              items: [
                ListTile(
                  leading: const Icon(Icons.perm_identity, color: Constants.providerBgColor,),
                  title: const Text("Name"),
                  subtitle: Text('${provider.salutation} ${provider.family_name} ${provider.given_name}'),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.perm_identity, color: Constants.providerBgColor),
                  title: const Text("Gender"),
                  subtitle: Text(provider.gender??''),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.card_membership, color: Constants.providerBgColor),
                  title: const Text("National Id"),
                  subtitle: Text(provider.national_id.toString()),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.card_membership, color: Constants.providerBgColor),
                  title: const Text("Licence Number"),
                  subtitle: Text(provider.licence_number??''),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.card_membership, color: Constants.providerBgColor),
                  title: const Text("Board Number"),
                  subtitle: Text(provider.board_number??''),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.card_membership, color: Constants.providerBgColor),
                  title: const Text("Cadre"),
                  subtitle: Text(provider.cadre??''),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.local_hospital_outlined, color: Constants.providerBgColor),
                  title: const Text("Facility"),
                  subtitle: Text(provider.facility_code??''),
                ),
                const Divider(),
              ],
            ),
            error: (error, _) => Center(child: Text(error.toString())),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
