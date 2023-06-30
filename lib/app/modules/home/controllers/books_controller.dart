import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pandora/app/data/constants.dart';

import 'home_controller.dart';

class BooksController extends HomeController with StateMixin {
  late PageController pageViewController;
  var pageBooksIndex = 0.obs;
  void getBooks(int index) async {
    print("=========>>>>>>当前是第$index页数据");

    box.write(BOOKPAGE, index);
    //刚开始显示加载中。。
    change(null, status: RxStatus.loading());
    //执行网络请求
    Response response = await homeProvider.getBooks(index);
    //请求出错时
    if (response.hasError) {
      change(null, status: RxStatus.error('Error'));
    } else {
      //请求成功时，显示数据
      String article = response.body['content'];
      change(article, status: RxStatus.success());
    }
  }

  @override
  void onInit() {
    super.onInit();
    //初始化时请求数据
    pageBooksIndex.value = box.read(BOOKPAGE) ?? 0;
    pageViewController = PageController(initialPage: box.read(BOOKPAGE) ?? 0);
    if (box.read(BOOKPAGE) == null) {
      getBooks(1);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    pageViewController.dispose();
  }
}
