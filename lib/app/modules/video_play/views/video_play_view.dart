import 'package:fl_video/fl_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';
import '../controllers/video_play_controller.dart';

class VideoPlayView extends GetView<VideoPlayController> {
  const VideoPlayView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          key: GlobalKey(),
          appBar: AppBar(
            title: Text(controller.title.value ?? ''),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    HomeController homeController = Get.find();
                    homeController.channel.sink.add(
                        '{"action":"play","url":"${controller.url.value}","title":"${controller.title}"}');
                  },
                  icon: const Icon(Icons.link))
            ],
          ),
          body: controller.url.isEmpty
              ? const SpinKitCircle(
                  color: Colors.black,
                  size: 50.0,
                )
              : Center(
                  child: FlVideoPlayer(
                      controller: FlVideoPlayerController(
                          autoPlay: true,
                          controls: CupertinoControls(
                            hideDuration: const Duration(seconds: 5),
                            enableSpeed: true,
                            enableSkip: true,
                            enableSubtitle: true,
                            enableFullscreen: true,
                            enableVolume: true,
                            enablePlay: true,
                            enableBottomBar: true,
                            onTap: (FlVideoTapEvent event,
                                FlVideoPlayerController controller) {
                              debugPrint(event.toString());
                            },
                            onDragProgress: (FlVideoDragProgressEvent event,
                                Duration duration) {
                              debugPrint('$event===$duration');
                            },
                            remainingBuilder: (String position) {
                              return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 6, 6, 6),
                                  child: Text(position,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.red)));
                            },
                            positionBuilder: (String position) {
                              return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(6, 6, 0, 6),
                                  child: Text(position,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.lightBlue)));
                            },
                          ),
                          videoPlayerController: controller.playController!)),
                ),
        ));
  }
}
