import 'package:get/get.dart';
import 'package:pandora/provider/provider.dart';

import '../controllers/books_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/lives_controller.dart';
import '../controllers/videos_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeProvider());
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<BooksController>(
      () => BooksController(),
    );
    Get.lazyPut<VideosController>(
      () => VideosController(),
    );
    Get.lazyPut<LivesController>(
      () => LivesController(),
    );
  }
}
