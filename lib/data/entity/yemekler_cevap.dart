

import 'package:bitirmeprojesi/data/entity/yemekler.dart';

class YemeklerCevap{
  List<Yemekler> yemekler;
  int success;

  YemeklerCevap({required this.yemekler,required this.success});

  factory YemeklerCevap.fromJson(Map<String,dynamic> json)
  {
    var jsonArrayYemek = json["yemekler"] as List;
    var yemekler = jsonArrayYemek.map((jsonArrayNesnesiYemek) => Yemekler.fromJson(jsonArrayNesnesiYemek)).toList();
    return YemeklerCevap(
        yemekler: yemekler,
      success: json["success"]as int
    );
  }

}