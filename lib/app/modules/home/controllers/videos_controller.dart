import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/models.dart';
import 'home_controller.dart';

class VideosController extends HomeController with StateMixin<List<Videos>> {
  late PageController pageViewController;
  var pageVideosIndex = 0.obs;
  var res = "maowu".obs;
  List<Videos> videos = [];
  void getVideoList(int index) async {
    print("=========>>>>>>当前是第$index页数据");
    if (index == 0) {
      pageVideosIndex.value = 0;
      videos.clear();
    }
    //刚开始显示加载中。。
    // change(videos, status: RxStatus.loading());
    //执行网络请求
    Response response = await homeProvider
        .searchVideos("", pageVideosIndex.value, res: res.value);
    print(">>>>>>${response.body}");
    //请求出错时
    if (response.hasError) {
      change(null, status: RxStatus.error('Error'));
    } else {
      //请求成功时，显示数据
      VideosResponse videosResponse = VideosResponse.fromJson(response.body);
      // String? videos = response.body['m3u8'];
      videos.addAll(videosResponse.data ?? []);
      pageVideosIndex.value++;
      change(videos, status: RxStatus.success());
    }
  }

  @override
  void onInit() {
    super.onInit();
    //初始化时请求数据
    // box.remove(VIDEOPAGE);
    // pageVideosIndex.value = box.read(VIDEOPAGE) ?? 0;
    // pageViewController = PageController(initialPage: box.read(VIDEOPAGE) ?? 0);
    // if (box.read(VIDEOPAGE) == null) {
    //   getVideoList(0);
    // }
    getVideoList(0);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
