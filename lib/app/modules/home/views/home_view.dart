import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pandora/app/data/constants.dart';

import '../controllers/books_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/videos_controller.dart';
import 'books_view.dart';
import 'lives_view.dart';
import 'videos_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const BooksView(),
          const VideosView(),
          const LivesView(),
        ],
        onPageChanged: (index) {
          if (index == 0) {
            BooksController booksController = Get.find();
            booksController.pageViewController =
                PageController(initialPage: (box.read(BOOKPAGE) ?? 1) - 1);
          } else if (index == 1) {
            VideosController videosController = Get.find();
            videosController.pageViewController =
                PageController(initialPage: (box.read(VIDEOPAGE) ?? 0));
          }
        },
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        /// Provide NotchBottomBarController
        notchBottomBarController: controller.controller,
        color: Colors.white,
        showLabel: false,
        notchColor: Colors.black87,

        /// restart app if you change removeMargins
        removeMargins: false,
        bottomBarWidth: 500,
        durationInMilliSeconds: 300,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.book_outlined,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.book_sharp,
              color: Colors.blueAccent,
            ),
            itemLabel: '小说',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.ondemand_video_outlined,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.ondemand_video_sharp,
              color: Colors.blueAccent,
            ),
            itemLabel: 'Page 2',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.live_tv_outlined,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.live_tv_sharp,
              color: Colors.blueAccent,
            ),
            itemLabel: 'Page 2',
          ),
        ],
        onTap: (index) {
          /// perform action on tab change and to update pages you can update pages without pages
          controller.pageController.jumpToPage(index);
        },
      ),
    );
  }
}
