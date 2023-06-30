import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class VideosResponse {
  VideosResponse({
    this.data,
  });

  factory VideosResponse.fromJson(Map<String, dynamic> json) {
    final List<Videos>? data = json['data'] is List ? <Videos>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          data.add(Videos.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return VideosResponse(
      data: data,
    );
  }

  List<Videos>? data;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'data': data,
      };
}

class Videos {
  Videos({
    this.tittle,
    this.url,
    this.img,
    this.hot,
  });

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        tittle: asT<String?>(json['tittle']),
        url: asT<String?>(json['url']),
        img: asT<String?>(json['img']),
        hot: asT<String?>(json['hot']),
      );

  String? tittle;
  String? url;
  String? img;
  String? hot;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'tittle': tittle,
        'url': url,
        'img': img,
        'hot': hot,
      };
}
