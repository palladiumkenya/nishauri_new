import 'package:flutter/material.dart';

class UserDrawerHeader extends StatelessWidget {
  final String? email;
  final String name;
  final String phoneNumber;
  final String? image;

  const UserDrawerHeader(
      {super.key,
      this.email,
      required this.name,
      required this.phoneNumber,
      this.image});

  get getAvatar => image != null && image!.isNotEmpty
      ? Image.network(image!)
      : Text(name.substring(0, 1).toUpperCase());

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Row(
        children: [
          CircleAvatar(
            radius: 50,
            child: getAvatar,
          ),
          const SizedBox(
            width: 20,
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.email_outlined,
                      color: Colors.black54,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        email ?? "None",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      color: Colors.black54,
                      Icons.phone,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        phoneNumber,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
