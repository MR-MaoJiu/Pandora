import 'package:get/get.dart';

import '../controllers/video_play_controller.dart';

class VideoPlayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoPlayController>(
      () => VideoPlayController(),
    );
  }
}
