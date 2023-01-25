
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:bitirmeprojesi/data/entity/yemekler.dart';
import 'package:bitirmeprojesi/data/entity/yemekler_cevap.dart';
import 'package:bitirmeprojesi/data/entity/sepet_yemekler.dart';
import 'package:bitirmeprojesi/data/entity/sepet_cevap.dart';

class YemeklerDaoRepo{

  List<Yemekler> parseYemeklerCevap(String cevap){
    return YemeklerCevap.fromJson(json.decode(cevap)).yemekler;
  }

  Future<List<Yemekler>> yemekleriYukle()async{
    var url =Uri.parse("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php");
    var cevap = await http.get(url);
    return parseYemeklerCevap(cevap.body);

  }

  Future<List<Yemekler>> yemekResimYukle(String yemek_resim_adi)async{

    var url =Uri.parse("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php");
    var veri = {"yemek_resim_adi":yemek_resim_adi};
    var cevap = await http.post(url,body: veri);
    print("yemek ${yemek_resim_adi}");


    return parseYemeklerCevap(cevap.body);//yukardaki fonksiyondan parse içlemini yaptık




  }

  // future sepete veri ekle.
  Future<void> sepeteEkle(String yemek_adi,String yemek_resim_adi, int yemek_fiyat, int yemek_siparis_adet, String kullanici_adi ) async{
    var url =Uri.parse("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php");
    var veri = {
      "yemek_adi":yemek_adi,
      "yemek_resim_adi":yemek_resim_adi,
      "yemek_fiyat":yemek_fiyat.toString(),
      "yemek_siparis_adet":yemek_siparis_adet.toString(),
      "kullanici_adi":kullanici_adi};//veriyi kayır etmek için;
    var cevap = await http.post(url,body: veri);//veb servis çaılışak veri gönderilecek
    print("Sepet Kayıt : ${cevap.body}");

  }

  // future sepetteki verileri getir kullanıci id sine göre.

  List<Sepet> parseSepetCevap(String cevap){

      return SepetCevap.fromJson(json.decode(cevap)).sepet_yemekler;
  }
  Future<List<Sepet>> sepetVerileriYukle(String kullanici_adi)async{
    var url =Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php");
    var veri ={"kullanici_adi":kullanici_adi};
    var cevap = await http.post(url,body: veri);
    try{
      return parseSepetCevap(cevap.body);
    }catch(error){
       print(error);
      List<Sepet>sepetyemekler=[];
      return sepetyemekler;
    }




    /*
    if(cevap.body.isEmpty){
      return [];
    }else{

    }*/


  }
  // Sepette aynı olan verileri güncelleme

  // future sepetten veri sil.

  Future<void> sil(int sepet_yemek_id, String kullanici_adi)async{
    /*var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php");
    var veri ={"sepet_yemek_id":sepet_yemek_id,"kullanici_adi":kullanici_adi};
    var cevap = await http.post(url,body: veri);
    print("Kişiyi Sil:${cevap.body}");*/


    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";// web servis
    var veri = {"sepet_yemek_id":sepet_yemek_id.toString(),"kullanici_adi":kullanici_adi};
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));//get türünde
    print("Kişi Sil: ${cevap.data.toString()}");


  }









}