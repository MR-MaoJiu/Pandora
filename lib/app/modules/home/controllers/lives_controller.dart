import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/models.dart';
import 'home_controller.dart';

class LivesController extends HomeController with StateMixin<List<Pingtai>> {
  late PageController pageViewController;
  List<Pingtai> pingTai = [];
  void getLiveList() async {
    //刚开始显示加载中。。
    // change(Lives, status: RxStatus.loading());
    pingTai.clear();
    //执行网络请求
    Response response = await homeProvider.getPingTai("/api/json.txt");
    print(">>>>>>${response.body}");
    //请求出错时
    if (response.hasError) {
      change(null, status: RxStatus.error('Error'));
    } else {
      //请求成功时，显示数据
      PingTaiResponse pingTaiResponse =
          PingTaiResponse.fromJson(json.decode('${response.body}'));
      pingTai.addAll(pingTaiResponse.pingtai ?? []);
      change(pingTai, status: RxStatus.success());
    }
  }

  @override
  void onInit() {
    super.onInit();
    //初始化时请求数据
    // box.remove(LivePAGE);
    // pageLivesIndex.value = box.read(LivePAGE) ?? 0;
    // pageViewController = PageController(initialPage: box.read(LivePAGE) ?? 0);
    // if (box.read(LivePAGE) == null) {
    //   getLiveList(0);
    // }
    getLiveList();
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
