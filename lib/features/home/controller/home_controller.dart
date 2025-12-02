import 'package:gibas/features/home/model/announcement.dart';
import 'package:gibas/features/home/repository/home_repository.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController with StateMixin<List<Announcement>> {
  late HomeRepository homeRepository;
  int totalVisit = 0;

  @override
  void onReady() {
    change(
      [
        Announcement(title: 'HUT Ke-23, Ormas GIBAS Resort Kota Bekasi ', image: 'https://proaksinews.com/wp-content/uploads/2024/01/IMG-20240114-WA0001.jpg'),
        Announcement(
          title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          image:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi-oy1vEGO_cczznyVWIyOU3ukponK7nSTywMuYbKHhCUY_31re39WsJxG24aUcunogAPX1Bh4uJcTe7B6rm1FBC_ecfCR5iDSM2jcqvdPKH1rGk_seIlG8RW47f9eLTm4o7iRRqfc2-yM1/s1600/IMG-20190128-WA0006.jpg',
        ),
        Announcement(
          title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          image:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhU-DOg672MugBdmvMoc9Iu6jMbpgK0pRX2POn-RCaWC595I-pqntcLL8xUJupqaThHgzHtV3jJ7zCxeSc7D7btV-WBp3zYjsutnv07yp48Kr1rNp1aMH3kjTsfuf6EU2fe4GiTwhnpmZ7S5HAkYbfGExio_yOkjWM5CMyznh98Z-I89a-cg6zgLYoMXIa6/w1200-h630-p-k-no-nu/Rony%20Romdhony%20Ketum%20GIBAS%20HUT%20ke-23.jpg',
        ),
      ],
      status: RxStatus.success(),
    );
    // homeRepository = HomeRepository();
    // fetchProgram();
    // getPermission();
    super.onReady();
  }

  void getPermission() async {
    await Permission.location.request();
    await Permission.camera.request();
  }

  String greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}
