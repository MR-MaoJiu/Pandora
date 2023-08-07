import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(
      // GetMaterialApp(
      //   title: "Pandora",
      //   initialRoute: AppPages.INITIAL,
      //   debugShowCheckedModeBanner: false,
      //   getPages: AppPages.routes,
      //   builder: EasyLoading.init(),
      // ),
      const MaterialApp(
    home: Pandora(),
  ));
}

class Pandora extends StatefulWidget {
  const Pandora({super.key});

  @override
  State<Pandora> createState() => _PandoraState();
}

class _PandoraState extends State<Pandora> {
  String url = '';
  @override
  void initState() {
    super.initState();

    const QuickActions quickActions = QuickActions();
    quickActions.initialize((shortcutType) async {
      if (shortcutType == 'real') {
        ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
        if (data != null) {
          //这里是一个剪贴板对象，调用data.text就是文本，其他的内容各位自行查看
          print(data);
          url = data.text ?? '';
          if (data.text == "[色][色][色]") {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return GetMaterialApp(
                title: "Pandora",
                initialRoute: AppPages.INITIAL,
                debugShowCheckedModeBanner: false,
                getPages: AppPages.routes,
                builder: EasyLoading.init(),
              );
            }));
          }
        }
      }
      // More handling code...
    });
    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
        type: 'real',
        localizedTitle: '卸载APP',
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: WebViewController()
        ..loadRequest(Uri.parse(url.isNotEmpty && url.contains('http')
            ? url
            : "http://www.ymxkj.com/vip/index.html")),
    );
  }
}
