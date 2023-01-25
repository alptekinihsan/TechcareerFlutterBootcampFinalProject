

import 'package:bitirmeprojesi/data/entity/sepet_yemekler.dart';

class SepetCevap{
  List<Sepet> sepet_yemekler;
  int success;

  SepetCevap({required this.sepet_yemekler,required this.success});

  factory SepetCevap.fromJson(Map<String,dynamic> json)
  {
    var jsonArraySepet = json["sepet_yemekler"] as List;
    var sepet_yemekler = jsonArraySepet.map((jsonArrayNesnesiSepet) =>Sepet.fromJson(jsonArrayNesnesiSepet)).toList();
    return SepetCevap(
        sepet_yemekler: sepet_yemekler,
        success: json ["success"] as int
    );
  }
}