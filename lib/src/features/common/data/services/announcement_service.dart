import 'package:nishauri/src/features/common/data/models/announcement.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';

class AnnouncementService extends HTTPService {
  final List<Announcement> _announcements = [
    const Announcement(
      id: "1",
      image: "https://picsum.photos/seed/pizza/200/300",
      source: "https://picsum.photos/seed/pizza/200/300",
      title: "Pizza Party",
      description:
          "Who doesn't love pizza? Join us for a pizza party on 28th November 2023 at the Juja Community Center. Enjoy unlimited slices of pizza from various toppings and flavors, along with drinks and desserts. Tickets are only 500 KES per person. Hurry, limited seats available!",
    ),
    const Announcement(
      id: "2",
      image: "https://picsum.photos/seed/music/200/300",
      source: "https://picsum.photos/seed/music/200/300",
      title: "Music Concert",
      description:
          "Get ready for a night of music and fun with our live music concert on 29th November 2023 at the Juja Stadium. Featuring some of the best local and international artists, this concert will make you dance and sing along. Tickets are on sale now, starting from 1000 KES. Don't miss this opportunity to see your favorite stars live!",
    ),
    const Announcement(
      id: "2",
      image: "https://picsum.photos/seed/flower/200/300",
      source: "https://picsum.photos/seed/flower/200/300",
      title: "Flower Festival",
      description: "Join us for a colorful celebration of flowers and nature on 25th November 2023 at the Juja Botanical Garden. Enjoy the beauty of various floral arrangements, live music, food stalls, and workshops. Admission is free for all ages.",
    ),
  ];

  Future<List<Announcement>> getAnnouncements() async {
    return _announcements;
  }
}
