import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:markdown_widget/config/all.dart';
import 'package:markdown_widget/widget/markdown.dart';
import 'package:pandora/app/modules/home/controllers/books_controller.dart';

class BooksView extends GetView<BooksController> {
  const BooksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(
              () => Text('小说&漫画（第${controller.pageBooksIndex.value + 1}个文章）')),
          centerTitle: true,
        ),
        body: PageView.builder(
          controller: controller.pageViewController,
          onPageChanged: (index) {
            print(
                "=========>>>>>>onPageChanged:$index==${controller.pageViewController.initialPage}==${controller.pageViewController.page}");
            controller.getBooks(index + 1);
            controller.pageBooksIndex.value = index;
          },
          itemBuilder: (context, index) {
            return controller.obx(
              (data) => MarkdownWidget(
                data: html2md.convert(data),
                selectable: false,
                shrinkWrap: true,
                markdownGeneratorConfig: MarkdownGeneratorConfig(),
              ),
              //onLoading: const CupertinoActivityIndicator(radius: 10), //加载中，默认是个Center(child:CircularProgressIndicator())
              onEmpty: const Text('No data found'), //空数据显示
              onError: (error) => Text(error!), //出错界面显示
              onLoading: const SpinKitCircle(
                color: Colors.black,
                size: 50.0,
              ), //加载界面显示
            );
          },
        ));
  }
}
