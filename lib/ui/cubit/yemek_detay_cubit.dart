import 'package:bitirmeprojesi/data/repo/yemeklerdao_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YemekDetayCubit extends Cubit<void>{

  YemekDetayCubit():super(0);

  var ysrepo =YemeklerDaoRepo();

  var yrepo = YemeklerDaoRepo();
  Future<void> yemekleriYukle()async{
    var liste = await yrepo.yemekleriYukle();
    emit(liste);
  }



  Future<void> sepeteEkle(String yemek_adi, String yemek_resim_adi, String yemek_fiyat , String yemek_siparis_adet, String kullanici_adi)async{

    await ysrepo.sepeteEkle(yemek_adi,yemek_resim_adi,int.parse(yemek_fiyat),int.parse(yemek_siparis_adet),kullanici_adi);

  }



}