
import 'package:bitirmeprojesi/data/entity/sepet_yemekler.dart';
import 'package:bitirmeprojesi/data/repo/yemeklerdao_repo.dart';
import 'package:bitirmeprojesi/ui/cubit/yemek_detay_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetSayfaCubit extends Cubit<List<Sepet>>{

  SepetSayfaCubit():super(<Sepet>[]);
  var srepo= YemeklerDaoRepo();


  Future <void> sepetVerileriYukle(String kullanici_adi)async{
    var liste = await srepo.sepetVerileriYukle(kullanici_adi);
      emit(liste);


  }
  Future<void> sil(int sepet_yemek_id,String kullanici_adi)async{
      await srepo.sil(sepet_yemek_id, kullanici_adi);
      await sepetVerileriYukle(kullanici_adi);

  }


}