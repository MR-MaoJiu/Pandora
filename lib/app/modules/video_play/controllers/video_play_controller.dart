import 'package:fl_video/fl_video.dart';
import 'package:get/get.dart';

import '../../../../provider/home_provider.dart';

class VideoPlayController extends GetxController {
  var title = "".obs;
  var url = "".obs;
  HomeProvider homeProvider = Get.find();
  VideoPlayerController? playController;
  getVideo() async {
    String path =
        Get.arguments["url"].split(Uri.parse(Get.arguments["url"]).host)[1];
    print(">>>>>>>>>>>>>>>>>>>$path");
    Response response = await homeProvider.getVideo(path);
    print(">>>>>>>>>>>>>>>>>>>$response");
    url.value = response.body['m3u8'];
    playController = VideoPlayerController.networkUrl(Uri.parse(url.value));
    url.refresh();

    print(">>>>>>>>>>>>>>>>>>>${url.value}");
  }

  @override
  void onInit() {
    super.onInit();
    title.value = Get.arguments["title"];

    if (Get.arguments["isZhuBo"] != null && Get.arguments["isZhuBo"]) {
      print(">>>>>>>>>>>>>>>>>>>${Get.arguments["url"]}");
      url.value = Get.arguments["url"];
      playController = VideoPlayerController.networkUrl(Uri.parse(url.value));
    } else {
      getVideo();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    playController?.dispose();
  }
}
