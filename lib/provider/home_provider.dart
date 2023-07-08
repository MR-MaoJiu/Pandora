import 'package:get/get.dart';

import 'base_provider.dart';

class HomeProvider extends BaseProvider {
  Future<Response> getBooks(int id) =>
      get('/sp/se/txt/lk_lebo_txtlist.php?txtid=$id');
  // Future<Response> getVideos(int id, {String res = "maowu"}) =>
  //     get('/sp/se/$res/play.php?id=$id');
  Future<Response> getVideo(String url) => get(url);
  Future<Response> getPingTai(String url) => get(url);
  Future<Response> getZhuBo(String url) => get(url);
  Future<Response> searchVideos(String searchText, int page,
          {String res = "maowu"}) =>
      get('/sp/se/$res/list.php?lk=so&s=$searchText&p=$page');
}
