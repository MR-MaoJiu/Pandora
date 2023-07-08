import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class PingTaiResponse {
  PingTaiResponse({
    this.result,
    this.msg,
    this.pingtai,
  });

  factory PingTaiResponse.fromJson(Map<String, dynamic> json) {
    final List<Pingtai>? pingtai = json['pingtai'] is List ? <Pingtai>[] : null;
    if (pingtai != null) {
      for (final dynamic item in json['pingtai']!) {
        if (item != null) {
          pingtai.add(Pingtai.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return PingTaiResponse(
      result: asT<String?>(json['result']),
      msg: asT<String?>(json['msg']),
      pingtai: pingtai,
    );
  }

  String? result;
  String? msg;
  List<Pingtai>? pingtai;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'result': result,
        'msg': msg,
        'pingtai': pingtai,
      };
}

class Pingtai {
  Pingtai({
    this.title,
    this.xinimg,
    this.number,
    this.address,
  });

  factory Pingtai.fromJson(Map<String, dynamic> json) => Pingtai(
        title: asT<String?>(json['title']),
        xinimg: asT<String?>(json['xinimg']),
        number: asT<String?>(json['Number']),
        address: asT<String?>(json['address']),
      );

  String? title;
  String? xinimg;
  String? number;
  String? address;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'xinimg': xinimg,
        'Number': number,
        'address': address,
      };
}
