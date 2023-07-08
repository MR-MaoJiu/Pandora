import 'dart:convert';
import 'base_models.dart';

class ZhuBoResponse {
  ZhuBoResponse({
    this.result,
    this.msg,
    this.zhubo,
  });

  factory ZhuBoResponse.fromJson(Map<String, dynamic> json) {
    final List<Zhubo>? zhubo = json['zhubo'] is List ? <Zhubo>[] : null;
    if (zhubo != null) {
      for (final dynamic item in json['zhubo']!) {
        if (item != null) {
          zhubo.add(Zhubo.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return ZhuBoResponse(
      result: asT<int?>(json['result']),
      msg: asT<String?>(json['msg']),
      zhubo: zhubo,
    );
  }

  int? result;
  String? msg;
  List<Zhubo>? zhubo;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'result': result,
        'msg': msg,
        'zhubo': zhubo,
      };
}

class Zhubo {
  Zhubo({
    this.title,
    this.img,
    this.address,
    this.pep,
  });

  factory Zhubo.fromJson(Map<String, dynamic> json) => Zhubo(
        title: asT<String?>(json['title']),
        img: asT<String?>(json['img']),
        address: asT<String?>(json['address']),
        pep: asT<String?>(json['pep']),
      );

  String? title;
  String? img;
  String? address;
  String? pep;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'img': img,
        'address': address,
        'pep': pep,
      };
}
