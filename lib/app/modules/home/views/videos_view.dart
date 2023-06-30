import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh_strong/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pandora/app/modules/home/controllers/videos_controller.dart';

class VideosView extends GetView<VideosController> {
  const VideosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() => Text('第${controller.pageVideosIndex.value + 1}视频')),
          actions: [
            IconButton(
                onPressed: () {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return CupertinoActionSheet(
                          title: Text("请选择资源地址"),
                          actions: [
                            CupertinoActionSheetAction(
                              child: Text("猫呜"),
                              onPressed: (() {
                                controller.res.value = "maowu";
                                Get.back();
                              }),
                            ),
                            CupertinoActionSheetAction(
                              child: Text("樱花"),
                              onPressed: (() {
                                controller.res.value = "yinghua";
                                Get.back();
                              }),
                            ),
                            CupertinoActionSheetAction(
                              child: Text("樱桃"),
                              onPressed: (() {
                                controller.res.value = "yingtao";
                                Get.back();
                              }),
                            ),
                            CupertinoActionSheetAction(
                              child: Text("可乐"),
                              onPressed: (() {
                                controller.res.value = "kele";
                                Get.back();
                              }),
                            ),
                            CupertinoActionSheetAction(
                              child: Text("热浪"),
                              onPressed: (() {
                                controller.res.value = "relang";
                                Get.back();
                              }),
                            ),
                          ],
                        );
                      });
                },
                icon: Icon(Icons.import_export_outlined))
          ],
          centerTitle: true,
        ),
        body: controller.obx(
          (data) => EasyRefresh(
            onRefresh: () async {
              controller.getVideoList(0);
            },
            onLoad: () async {
              controller.getVideoList(controller.pageVideosIndex.value);
            },
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(child: Stack(
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
                      child: Text(
                        "${data?[index].tittle}",
                        style: TextStyle(color: Colors.white),
                      ),
                      decoration: BoxDecoration(color: Colors.black12),
                    )
                  ],
                ),onTap: (){
                  Get.toNamed(page)
                },);
              },
              itemCount: (data ?? []).length,
            ),
          ),
          onEmpty: const Text('No data found'), //空数据显示
          onError: (error) => TextButton(
              onPressed: () {
                controller.getVideoList(0);
              },
              child: Text(error!)), //出错界面显示
          onLoading: SpinKitCircle(
            color: Colors.black,
            size: 50.0,
          ), //加载界面显示
        )
        // body: PageView.builder(
        //   controller: controller.pageViewController,
        //   onPageChanged: (index) {
        //     print(
        //         "=========>>>>>>onPageChanged:$index==${controller.pageViewController.initialPage}==${controller.pageViewController.page}");
        //     controller.getVideos(index);
        //     controller.pageVideosIndex.value = index;
        //   },
        //   itemBuilder: (context, index) {
        //     return controller.obx(
        //       (data) => MarkdownWidget(
        //         data: html2md.convert(data ?? ''),
        //         selectable: false,
        //         shrinkWrap: true,
        //         markdownGeneratorConfig: MarkdownGeneratorConfig(),
        //       ),
        //       //onLoading: const CupertinoActivityIndicator(radius: 10), //加载中，默认是个Center(child:CircularProgressIndicator())
        //       onEmpty: const Text('No data found'), //空数据显示
        //       onError: (error) => Text(error!), //出错界面显示
        //       onLoading: SpinKitCircle(
        //         color: Colors.black,
        //         size: 50.0,
        //       ), //加载界面显示
        //     );
        //   },
        // )
        );
  }
}
