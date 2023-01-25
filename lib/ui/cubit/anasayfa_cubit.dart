import 'package:bitirmeprojesi/data/entity/yemekler.dart';
import 'package:bitirmeprojesi/data/repo/yemeklerdao_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>>{

  AnasayfaCubit():super(<Yemekler>[]);
  var yrepo = YemeklerDaoRepo();
  Future<void> yemekleriYukle()async{
    var liste = await yrepo.yemekleriYukle();
    emit(liste);
  }

  Future<void> ara(String aramaKelimesi)async{
    var liste = await yrepo.yemekResimYukle(aramaKelimesi);
    emit(liste);
    await yemekleriYukle();
  }



}