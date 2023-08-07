import 'package:get/get.dart';

import '../controllers/zhubo_controller.dart';

class ZhuboBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ZhuboController>(
      () => ZhuboController(),
    );
  }
}
