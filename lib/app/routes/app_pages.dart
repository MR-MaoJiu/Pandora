import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/video_play/bindings/video_play_binding.dart';
import '../modules/video_play/bindings/video_play_binding.dart';
import '../modules/video_play/views/video_play_view.dart';
import '../modules/video_play/views/video_play_view.dart';
import '../modules/zhubo/bindings/zhubo_binding.dart';
import '../modules/zhubo/views/zhubo_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO_PLAY,
      page: () => const VideoPlayView(),
      binding: VideoPlayBinding(),
      children: [
        GetPage(
          name: _Paths.VIDEO_PLAY,
          page: () => const VideoPlayView(),
          binding: VideoPlayBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.ZHUBO,
      page: () => const ZhuboView(),
      binding: ZhuboBinding(),
    ),
  ];
}
