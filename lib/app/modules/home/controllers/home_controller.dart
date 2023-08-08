import 'dart:convert';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pandora/provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  final PageController pageController = PageController();
  final controller = NotchBottomBarController(index: 0);
  HomeProvider homeProvider = Get.find();
  final channel = WebSocketChannel.connect(
      Uri.parse('wss://echo.websocket.events'),
      protocols: [
        "Sec-WebSocket-Accept: gc+s+U3d2zdNlgaXtkelWiFcRNo=",
        "WebSocket-Location: ws://180.174.237.78:9527/demo/shout.php",
        "WebSocket-Origin: 180.174.237.78",
        "Connection: Upgrade",
        "Upgrade: websocket"
      ]);
  @override
  void onInit() {
    super.onInit();
    //初始化时请求数据
    // 监听WebSocket连接状态
    channel.stream.listen((event) {
      if (event is String) {
        // 处理接收到的数据
        print('Received: $event');
        Map data = json.decode(event);
        if (data['action'] == 'play') {
          Get.toNamed(Routes.VIDEO_PLAY,
              arguments: {"title": data['title'], "url": data['url']});
        }
      }
    }, onError: (error) {
      // 处理错误
      print('Error: $error');
    }, onDone: () {
      // 处理连接关闭
      print('Connection closed');
    });
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
