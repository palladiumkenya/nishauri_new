import 'package:flutter/material.dart';

class AccountInformation extends StatelessWidget {
  final TextEditingController username;
  final TextEditingController phoneNumber;
  final TextEditingController email;

  const AccountInformation(
      {super.key,
      required this.username,
      required this.phoneNumber,
      required this.email});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
