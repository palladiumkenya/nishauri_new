import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/provider/provider_registry/data/providers/provider_registry_provider.dart';
import 'package:nishauri/src/hooks/use_local_avatar.dart';
import 'package:nishauri/src/utils/constants.dart';

class ProviderRegistry extends HookConsumerWidget {
  const ProviderRegistry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final avatar = useLocalAvatar("images/avatar.jpg");
    return Consumer(
      builder: (context, ref, child) {
        final asyncProvider = ref.watch(getProviderDetailsProvider);
        return asyncProvider.when(
          data: (provider) => Container(
            child: Wrap ( children: [
              const Divider(),
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
          ),
            error: (error, _) => Center(child: Text(error.toString())),
            loading: () => const Center(
              child: CircularProgressIndicator(),),
          );
  },
  );
}
}