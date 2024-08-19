import 'dart:convert';
import 'dart:developer';

import 'package:nishauri/src/features/common/data/models/announcement.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/helpers.dart';

class AnnouncementService extends HTTPService {
  final List<Announcement> _announcements = [
    const Announcement(
      id: "1",
      image:
          "https://www.emeraldgrouppublishing.com/sites/default/files/image/covid-cells.jpg",
      source:
          "https://www.emeraldgrouppublishing.com/sites/default/files/image/covid-cells.jpg",
      title: "Covid-19 Variants",
      description:
          "Since the beginning of the COVID-19 pandemic and with the evolution of "
          "the SARS-CoV-2 virus, multiple COVID-19 Variants of Concern (VOCs) "
          "and Variants of Interest (VOIs) have been designated by WHO based on "
          "their assessed potential for expansion and replacement of prior variants, "
          "for causing new waves with increased circulation, and for the need "
          "for adjustments to public health actions.",
    ),
    // const Announcement(
    //   id: "2",
    //   image: "https://picsum.photos/seed/music/200/300",
    //   source: "https://picsum.photos/seed/music/200/300",
    //   title: "Music Concert",
    //   description:
    //       "Get ready for a night of music and fun with our live music concert on 29th November 2023 at the Juja Stadium. Featuring some of the best local and international artists, this concert will make you dance and sing along. Tickets are on sale now, starting from 1000 KES. Don't miss this opportunity to see your favorite stars live!",
    // ),
    // const Announcement(
    //   id: "2",
    //   image: "https://picsum.photos/seed/flower/200/300",
    //   source: "https://picsum.photos/seed/flower/200/300",
    //   title: "Flower Festival",
    //   description: "Join us for a colorful celebration of flowers and nature on 25th November 2023 at the Juja Botanical Garden. Enjoy the beauty of various floral arrangements, live music, food stalls, and workshops. Admission is free for all ages.",
    // ),
  ];

  Future<List<Announcement>> getAnnouncements() async {
    final data = await loadJsonData("assets/data/announcements.json");
    final json = jsonDecode(data);
    final announce = json
        .map((an) => Announcement.fromJson(Map<String, dynamic>.from(an))).toList();

    log("$announce");
    return [...announce];
  }
}
