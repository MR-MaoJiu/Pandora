import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh_strong/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pandora/app/modules/home/controllers/videos_controller.dart';

import '../../../routes/app_pages.dart';

class VideosView extends GetView<VideosController> {
  const VideosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AnimationSearchBar(
            backIcon: Icons.arrow_back_ios_new,
            backIconColor: Colors.white,
            isBackButtonVisible: true,
            centerTitle: '视频',
            hintText: '搜一搜...',
            closeIconColor: Colors.white,
            centerTitleStyle: const TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white, fontSize: 20),
            //? Search hint text
            hintStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w300),
            //? Search Text
            textStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w300),
            //? Cursor color
            cursorColor: Colors.lightBlue.shade300,
            //? Duration
            duration: const Duration(milliseconds: 500),
            searchBarWidth: Get.width - 80, // Total width of this Widget
            verticalPadding: 0,
            //? Search icon color
            searchIconColor: Colors.white.withOpacity(.7),
            //? Search field background decoration
            searchFieldDecoration: BoxDecoration(
                color: Colors.blueGrey.shade700,
                border:
                    Border.all(color: Colors.black.withOpacity(.2), width: .5),
                borderRadius: BorderRadius.circular(15)),
            searchTextEditingController: controller.textController,
            onChanged: (search) {
              controller.searchTitle.value = search;
              controller.getVideoList(0);
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return CupertinoActionSheet(
                          title: const Text("请选择资源地址"),
                          actions: [
                            CupertinoActionSheetAction(
                              onPressed: (() {
                                controller.res.value = "maowu";
                                Get.back();
                              }),
                              child: const Text("猫呜"),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: (() {
                                controller.res.value = "yinghua";
                                Get.back();
                              }),
                              child: const Text("樱花"),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: (() {
                                controller.res.value = "yingtao";
                                Get.back();
                              }),
                              child: const Text("樱桃"),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: (() {
                                controller.res.value = "kele";
                                Get.back();
                              }),
                              child: const Text("可乐"),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: (() {
                                controller.res.value = "relang";
                                Get.back();
                              }),
                              child: const Text("热浪"),
                            ),
                          ],
                        );
                      });
                },
                icon: const Icon(Icons.import_export_outlined))
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
                        decoration: const BoxDecoration(color: Colors.black12),
                        child: Text(
                          "${data?[index].tittle}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    Get.toNamed(Routes.VIDEO_PLAY, arguments: {
                      "title": data?[index].tittle,
                      "url": data?[index].url
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
                controller.getVideoList(0);
              },
              child: Text(error!)), //出错界面显示
          onLoading: const SpinKitCircle(
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
