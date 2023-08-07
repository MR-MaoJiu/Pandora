import 'dart:convert';

import 'package:get/get.dart';
import 'package:pandora/app/data/models/models.dart';
import 'package:pandora/app/modules/home/controllers/home_controller.dart';

class ZhuboController extends HomeController with StateMixin<List<Zhubo>> {
  List<Zhubo> zhuBo = [];
  var title = ''.obs;
  void getZhuBoList() async {
    //刚开始显示加载中。。
    // change(Lives, status: RxStatus.loading());
    zhuBo.clear();
    //执行网络请求
    Response response =
        await homeProvider.getPingTai("/api/${Get.arguments['pingtai']}");
    print(">>>>>>${response.body}");
    //请求出错时
    if (response.hasError) {
      change(null, status: RxStatus.error('Error'));
    } else {
      //请求成功时，显示数据
      ZhuBoResponse zhuBoResponse =
          ZhuBoResponse.fromJson(json.decode('${response.body}'));
      zhuBo.addAll(zhuBoResponse.zhubo ?? []);
      change(zhuBo, status: RxStatus.success());
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
    title.value = Get.arguments['title'];
    getZhuBoList();
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
