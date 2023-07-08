import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh_strong/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pandora/app/modules/home/controllers/lives_controller.dart';


class LivesView extends GetView<LivesController> {
  const LivesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('直播平台'),
        centerTitle: true,
      ),
      body: controller.obx(
        (data) => EasyRefresh(
          onRefresh: () async {
            controller.getLiveList();
          },
          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ExtendedImage.network(
                      data?[index].xinimg ?? '',
                      height: Get.height,
                      fit: BoxFit.cover,
                      cache: true,
                      //cancelToken: cancellationToken,
                    ),
                    Container(
                      width: Get.width,
                      decoration: const BoxDecoration(color: Colors.black12),
                      child: Text(
                        "${data?[index].title}(${data?[index].number}人)",
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                onTap: () {
//                  Get.toNamed(Routes.VIDEO_PLAY, arguments: {
//                    "title": data?[index].tittle,
//                    "url": data?[index].url
//                  });
                },
              );
            },
            itemCount: (data ?? []).length,
          ),
        ),
        onEmpty: const Text('No data found'), //空数据显示
        onError: (error) => TextButton(
            onPressed: () {
              controller.getLiveList();
            },
            child: Text(error!)), //出错界面显示
        onLoading: const SpinKitCircle(
          color: Colors.black,
          size: 50.0,
        ), //加载界面显示
      ),
    );
  }
}
