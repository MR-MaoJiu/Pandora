import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh_strong/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/zhubo_controller.dart';

class ZhuboView extends GetView<ZhuboController> {
  const ZhuboView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.title.value)),
        centerTitle: true,
      ),
      body: controller.obx(
        (data) => EasyRefresh(
          onRefresh: () async {
            controller.getZhuBoList();
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
                      data?[index].img ?? '',
                      height: Get.height,
                      fit: BoxFit.cover,
                      cache: true,
                      //cancelToken: cancellationToken,
                    ),
                    Container(
                      width: Get.width,
                      decoration: const BoxDecoration(color: Colors.black12),
                      child: Text(
                        "${data?[index].title}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                onTap: () {
                  Get.toNamed(Routes.VIDEO_PLAY, arguments: {
                    "title": data?[index].title,
                    "url": data?[index].address,
                    "isZhuBo": true,
                  });
                },
              );
            },
            itemCount: (data ?? []).length,
          ),
        ),
        onEmpty: const Text('No data found'), //空数据显示
        onError: (error) => TextButton(
            onPressed: () {
              controller.getZhuBoList();
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
