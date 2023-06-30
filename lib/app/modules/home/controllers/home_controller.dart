import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pandora/provider/provider.dart';

class HomeController extends GetxController {
  final PageController pageController = PageController();
  final controller = NotchBottomBarController(index: 0);
  HomeProvider homeProvider = Get.find();
  @override
  void onInit() {
    super.onInit();
    //初始化时请求数据
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
  }
}
